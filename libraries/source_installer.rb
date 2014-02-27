# Defines Rethinkdb source installer 

require_relative 'common_helpers'

module RethinkdbLib
  module SourceInstaller
    include PackageManagerHelper
    require 'uri'
    
    def check_support
      # checks if the current setup is supported
      if not platform_family?('debian', 'rhel', 'fedora')
        Chef::Log.error "Install from source not supported"
        raise UnsupportedInstallMethodError
      end
    end
    
    def include_dependencies(src_config, repo_config)
      # install correct package manager recipe
      include_recipe 'apt' if platform_family?('debian')
      include_recipe 'yum' if platform_family?('rhel', 'fedora')
      include_recipe 'yum-epel' if platform_family?('rhel')
      
      ## installs all package dependencies
      dependencies = repo_config['dependencies'] || []
      dependencies.each {|dependency| package dependency}
      
      # install build-essential
      include_recipe 'build-essential'
      
      # install nodejs
      include_recipe 'nodejs' if src_config['install_nodejs']
    end
    
    def rethinkdb_installed?(version)
      # check is rethinkdb is already installed for the expected version
      rethinkdb_bin = "/usr/local/bin/rethinkdb"
      if ::File.exists?(rethinkdb_bin)
        cmd = Mixlib::ShellOut.new("`#{rethinkdb_bin} --version`.chomp")
        current_version = cmd.run_command.stdout.to_s
        return current_version.eql? version
      end
      false
    end
    
    def get_source(src_config, version)
      # handles downloading and extracting source
      source_url = URI.join(src_config['dist_url']+'/', src_config['tar_filename'])
      download_path = File.join(src_config['path'], src_config['tar_filename'])
      untar_path = File.join(src_config['path'], "rethinkdb-#{version}")
      
      remote_file download_path do
        path download_path
        source source_url.to_s
        mode 0644
        action :create_if_missing
      end
      
      # --no-same-owner required overcome "Cannot change ownership" bug
      # on NFS-mounted filesystem
      execute "tar --no-same-owner -zxf #{src_config['tar_filename']}" do
        cwd src_config['path']
        creates untar_path
      end
    end
    
    def get_config_options config_options
      # gets config options 
      if config_options.nil? 
        return '--dynamic tcmalloc_minimal' if not platform_family?('debian')
      end
      config_options || ''
    end
    
    def install_source(src_config, version)
      untar_path = File.join(src_config['path'], "rethinkdb-#{version}")
      config_options = get_config_options src_config['config_options']
      
      bash "compile rethinkdb with options #{config_options}" do
        # OSX doesn't have the attribute so arbitrarily default 2
        cwd untar_path
        code <<-EOH
          PATH="/usr/local/bin:$PATH"
          ./configure #{config_options} && make
        EOH
        creates "#{untar_path}/rethinkdb"
      end
      
      execute "rethinkdb make install" do
        environment({"PATH" => "/usr/local/bin:/usr/bin:/bin:$PATH"})
        command "make install"
        cwd untar_path
      end
    end
    
    def install_rethinkdb(config_helper)
      
      # check if the install is supported
      self.check_support
      
      # relevant config for source installation
      version = config_helper.version
      src_config = config_helper.install_config 'src'
      repo_config = config_helper.pkg_config 'src', package_manager
      
      if self.rethinkdb_installed? version
        # Log already installed
        return 
      end
      
      self.include_dependencies src_config, repo_config
      self.get_source src_config, version
      self.install_source src_config, version
    end
  end
end
