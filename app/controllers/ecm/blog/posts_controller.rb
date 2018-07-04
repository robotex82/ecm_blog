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

      helper Rails::AddOns::TableHelper

      def self.resource_class
        Ecm::Blog::Post
      end

      private

      def load_collection_scope
        if params.has_key?(:year)
          super.published.for_date(params[:year], params[:month], params[:day])
        else
          super.published.order(created_at: :desc)
        end
      end

      def load_resource_scope
        super.published.friendly
      end
    end
  end
end