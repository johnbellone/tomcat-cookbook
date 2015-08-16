#
# Cookbook: tomcat
# License: Apache 2.0
#
# Copyright 2010, Chef Software, Inc.
# Copyright 2015, Bloomberg Finance L.P.
#

node.default['java']['jdk_version'] = '7'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

poise_service_user node['tomcat']['service_user'] do
  group node['tomcat']['service_group']
end

tomcat_config node['tomcat']['service_name'] do |r|
  owner node['tomcat']['service_user']
  group node['tomcat']['service_group']

  node['tomcat']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "tomcat_service[#{name}]", :delayed
end

tomcat_service node['tomcat']['service_name'] do |r|
  user node['tomcat']['service_user']
  group node['tomcat']['service_group']

  node['tomcat']['service'].each_pair { |k, v| r.send(k, v) }
end
