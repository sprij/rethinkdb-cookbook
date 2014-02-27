name             'rethinkdb'
maintainer       'sprij'
maintainer_email 's.rijo@yahoo.com'
license          'Apache 2.0'
description      'Installs/Configures rethinkdb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'yum', '>= 3.0'
depends 'yum-epel'
depends 'build-essential'
depends 'nodejs'

%w{ubuntu, centos, debian, fedora}.each do |os|
  supports os
end
