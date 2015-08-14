name 'tomcat'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs/Configures tomcat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

supports 'debian'
supports 'ubuntu'
supports 'centos'
supports 'redhat'
supports 'amazon'
supports 'scientific'

depends 'java'
depends 'poise', '~> 2.2'
depends 'poise-service', '~> 1.0'
