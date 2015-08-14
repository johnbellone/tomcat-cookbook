#
# Cookbook: tomcat
# License: Apache 2.0
#
# Copyright 2010, Chef Software, Inc.
# Copyright 2015 Bloomberg Finance L.P.
#
require 'poise'

module TomcatCookbook
  module Resource
    class TomcatConfig < Chef::Resource
      include Poise(fused: true)
      provides(:tomcat_config)

      property(:path, kind_of: String, name_attribute: true)
      property(:owner, kind_of: String, default: 'tomcat')
      property(:group, kind_of: String, default: 'tomcat')

      property(:home_dir, kind_of: String, default: '/usr/share/tomcat')
      property(:temp_dir, kind_of: String, default: '/var/tmp/tomcat')
      property(:webapps_dir, kind_of: String, default: '/var/lib/tomcat/webapps')
      property(:work_dir, kind_of: String, default: '/var/cache/tomcat')

      action(:create) do
        notifying_block do
          config_dir = Dir.dirname(basenanew_resource.path)
          context_dir = File.join(config_dir, 'Catalina', 'localhost')
          directory [config_dir,
                     context_dir,
                     new_resource.home_dir,
                     new_resource.webapps_dir,
                     new_resource.work_dir] do
            recursive true
            owner new_resource.owner
            group new_resource.group
          end
        end
      end
    end
  end
end
