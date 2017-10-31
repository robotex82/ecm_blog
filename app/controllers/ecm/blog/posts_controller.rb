module Ecm
  module Blog
    class PostsController < Ecm::Blog::Configuration.base_controller.constantize
      include Controller::ResourceConcern
      include Controller::ResourceUrlsConcern
      include Controller::ResourceInflectionsConcern
      include Controller::RestActionsConcern

      helper Ecm::Comments::ApplicationHelper

      def self.resource_class
        Ecm::Blog::Post
      end

      private

      def collection_scope
        super.published.order(updated_at: :desc)
      end

      def load_collection
        collection_scope.page(params[:page])
      end

      def load_scope
        super.published
      end
    end
  end
end