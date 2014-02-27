# Defines Rethinkdb package installer 
require_relative 'common_helpers'

module RethinkdbLib
  module PackageInstaller
    include PackageManagerHelper
    
    def check_support
      # checks if the current setup is supported
      if not platform?('ubuntu', 'centos')
        Chef::Log.error "Install from package not supported"
        raise UnsupportedInstallMethodError
      end
    end
    
    def include_dependencies
      include_recipe 'apt' if platform_family?('debian')
      include_recipe 'yum' if platform_family?('rhel', 'fedora')
    end
    
    def install_rethinkdb_with_apt(config_helper)
      rethinkdb_name = config_helper.name
      rethinkdb_version = config_helper.version
      rethinkdb_config = config_helper.pkg_config 'package', 'apt'
      
      # adding apt repo
      apt_repository rethinkdb_name do
        uri rethinkdb_config['url']
        distribution node['lsb']['codename']
        components ['main']
        keyserver rethinkdb_config['key_server']
        key rethinkdb_config['key']
        action :add
      end
      # install package
      apt_package rethinkdb_name do
        version "#{rethinkdb_version}*"
        action :install
      end    
    end
    
    def install_rethinkdb_with_yum(config_helper)
      rethinkdb_name = config_helper.name
      rethinkdb_version = config_helper.version
      rethinkdb_config = config_helper.pkg_config 'package', 'yum'
      
      # building repo URI
      # adding yum repo
      yum_repository rethinkdb_name do
        baseurl rethinkdb_config['url']
        gpgcheck false
        enabled true
        action :add
      end
      # install package
      yum_package "#{rethinkdb_name} = #{rethinkdb_version}" do
        action :install
      end
    end
    
    def install_rethinkdb(config_helper)
      self.check_support
      self.include_dependencies
      
      case self.package_manager
      when 'apt'
        self.install_rethinkdb_with_apt(config_helper)
      when 'yum'
        self.install_rethinkdb_with_yum(config_helper)
      end
    end
  end
  
end