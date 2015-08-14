#
# Cookbook: tomcat
# License: Apache 2.0
#
# Copyright 2010, Chef Software, Inc.
# Copyright 2015 Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module TomcatCookbook
  module Resource
    # @since 1.0.0
    class TomcatService < Chef::Resource
      include Poise
      provides(:tomcat_service)
      include PoiseService::ServiceMixin

      property(:instance_name, kind_of: String, name_attribute: true)
      property(:user, kind_of: String, default: 'tomcat')
      property(:group, kind_of: String, default: 'tomcat')

      property(:install_method, equal_to: %w{package binary}, default: 'binary')
      property(:version, kind_of: String, default: '8.0.24')
      property(:package_name, kind_of: String)
      property(:binary_url, kind_of: String)

      property(:log_dir, kind_of: String, default: '/var/log/tomcat')
    end
  end

  module Provider
    # @since 1.0.0
    class TomcatService < Chef::Provider
      include Poise
      provides(:tomcat_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          directory new_resource.log_dir do
            recursive true
            owner new_resource.user
            group new_resource.group
          end

          package new_resource.package_name do
            action :upgrade
            only_if { new_resource.install_method == 'package' }
          end
        end
        super
      end

      def action_disable
        notifying_block do

        end
        super
      end

      def service_options(service)
      end
    end
  end
end
