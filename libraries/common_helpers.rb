# Defines common helpes for the library RethinkdbLib

module RethinkdbLib
  class UnsupportedInstallMethodError < RuntimeError
  end
  
  module PackageManagerHelper
    # Module with a simple package manager helper
    def package_manager
      return 'apt' if platform_family?('debian')
      return 'yum' if platform_family?('rhel', 'fedora')
    end
  end
end
