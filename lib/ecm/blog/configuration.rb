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
      mattr_accessor(:posts_index_page_title_proc) { ->(view) { view.resource_class.model_name.human(count: :other) } }
      mattr_accessor(:pagination_options_proc) { ->(view) { { theme: 'twitter-bootstrap-3' } } }
      mattr_accessor(:preview_picture_asset_variant_options) { { resize: '320x240' } }
    end
  end
end
