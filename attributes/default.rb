#
# Cookbook: tomcat
# License: Apache 2.0
#
# Copyright 2010, Chef Software, Inc.
# Copyright 2015, Bloomberg Finance L.P.
#

default['tomcat']['version'] = '7.0.63'
default['tomcat']['service_name'] = 'tomcat'
default['tomcat']['service_user'] = 'tomcat'
default['tomcat']['service_group'] = 'tomcat'

default['tomcat']['service']['binary_url'] = "http://psg.mtu.edu/pub/apache/tomcat/tomcat-%{major_version}/v%{version}/bin/apache-tomcat-%{version}.tar.gz"
default['tomcat']['service']['binary_checksum'] = 'b5d878a17de2421a078d8907583076b507e67dbf1567c6f4346d70c88473f8ad'

case node['platform_family']
when 'rhel', 'fedora'
  default['tomcat']['service']['install_method'] = 'package'
  default['tomcat']['service']['package_name'] = 'tomcat'

  default['tomcat']['config']['path'] ='/etc/tomcat/tomcat.conf'
  default['tomcat']['config']['home_dir'] ='/usr/share/tomcat'
  default['tomcat']['config']['log_dir'] ='/var/log/tomcat'
  default['tomcat']['config']['tmp_dir'] ='/var/tmp/tomcat'
  default['tomcat']['config']['webapps_dir'] ='/var/lib/tomcat/webapps'
  default['tomcat']['config']['work_dir'] ='/var/cache/tomcat'
when 'smartos'
  default['tomcat']['service']['install_method'] = 'package'
  default['tomcat']['service']['package_name'] = 'apache-tomcat'

  default['tomcat']['config']['config_dir'] ='/opt/local/share/tomcat/conf/settings.conf'
  default['tomcat']['config']['home_dir'] ='/opt/local/share/tomcat'
  default['tomcat']['config']['log_dir'] ='/opt/local/share/tomcat/logs'
  default['tomcat']['config']['tmp_dir'] ='/opt/local/share/tomcat/tmp'
  default['tomcat']['config']['webapps_dir'] ='/opt/local/share/tomcat/webapps'
  default['tomcat']['config']['work_dir'] ='/opt/local/share/tomcat/work'
else
  if platform_family?('debian')
    default['tomcat']['service']['install_method'] = 'package'
    default['tomcat']['service']['package_name'] = 'tomcat7'
  else
    default['tomcat']['service']['install_method'] = 'binary'
  end

  default['tomcat']['config']['config_dir'] ='/etc/tomcat7'
  default['tomcat']['config']['home_dir'] ='/usr/share/tomcat7'
  default['tomcat']['config']['log_dir'] ='/var/log/tomcat7'
  default['tomcat']['config']['tmp_dir'] ='/var/tmp/tomcat7'
  default['tomcat']['config']['webapps_dir'] ='/var/lib/tomcat7/webapps'
  default['tomcat']['config']['work_dir'] ='/var/cache/tomcat7'
end

case node['platform_family']

when 'rhel', 'fedora'
  suffix = node['tomcat']['base_version'].to_i < 7 ? node['tomcat']['base_version'] : ""

  default['tomcat']['base_instance'] = "tomcat#{suffix}"
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = "/usr/share/tomcat#{suffix}"
  default['tomcat']['base'] = "/usr/share/tomcat#{suffix}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{suffix}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{suffix}"
  default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{suffix}/temp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{suffix}/work"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{suffix}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
  default['tomcat']['packages'] = ["tomcat#{suffix}"]
  default['tomcat']['deploy_manager_packages'] = ["tomcat#{suffix}-admin-webapps"]
when 'debian'
  default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
when 'smartos'
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = '/opt/local/share/tomcat'
  default['tomcat']['base'] = '/opt/local/share/tomcat'
  default['tomcat']['config_dir'] = '/opt/local/share/tomcat/conf'
  default['tomcat']['log_dir'] = '/opt/local/share/tomcat/logs'
  default['tomcat']['tmp_dir'] = '/opt/local/share/tomcat/temp'
  default['tomcat']['work_dir'] = '/opt/local/share/tomcat/work'
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = '/opt/local/share/tomcat/webapps'
  default['tomcat']['keytool'] = '/opt/local/bin/keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["home"]}/lib/endorsed"
  default['tomcat']['packages'] = ["apache-tomcat"]
  default['tomcat']['deploy_manager_packages'] = []
else
  default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
end
