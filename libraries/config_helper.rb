# Defines RethinkdbLib::ConfigHelper class to handle
# reading configuration from Chef::Node

module RethinkdbLib
  class ConfigHelper
    # Configuration helper
    def initialize(node)
      @node = node
      @name = 'rethinkdb'
    end
    
    def name
      @name
    end
    
    def version
      # Version to install
      @node[@name]['version']
    end
    
    def install_config(install_method)
      # Configuration for the current install method
      @node[@name][install_method]
    end
    
    def pkg_config(install_method, package_manager)
      # package manager config
      return @node[@name][install_method][package_manager]
    end
  end
end
