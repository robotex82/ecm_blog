require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Ecm
  module Blog
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:base_controller) { '::FrontendController' }
      mattr_accessor(:creator_class_name) { 'User' }
    end
  end
end
