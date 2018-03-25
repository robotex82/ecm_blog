module Ecm
  module Blog
    class PostsController < Ecm::Blog::Configuration.base_controller.constantize
      include ResourcesController::Resources
      include ResourcesController::ResourceInflections
      include ResourcesController::RestResourceUrls
      include ResourcesController::RestActions
      include ResourcesController::Kaminari
      include ResourcesController::LocationHistory

      helper Ecm::Comments::ApplicationHelper

      def self.resource_class
        Ecm::Blog::Post
      end

      private

      def load_collection_scope
        super.published.friendly.order(created_at: :desc)
      end

      def load_resource_scope
        super.published.friendly
      end
    end
  end
end