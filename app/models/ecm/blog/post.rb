module Ecm::Blog
  class Post < ActiveRecord::Base
    include Model::Ecm::Comments::CommentableConcern
    include Model::Ecm::Tags::TaggableConcern

    # acts as published
    include ActsAsPublished::ActiveRecord
    acts_as_published

    has_many_attached :assets if respond_to?(:has_many_attached)

    # slugs
    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :creator, class_name: Ecm::Blog.creator_class_name, foreign_key: 'created_by_id'
    belongs_to :updater, class_name: Ecm::Blog.creator_class_name, foreign_key: 'updated_by_id', optional: true

    def human
      title
    end

    module Markdown
      def body(format: nil)
        case format
        when :html
          to_markdown(read_attribute(:body))
        else
          read_attribute(:body)
        end
      end

      private

      def to_markdown(string)
        Kramdown::Document.new(string).to_html
      end
    end

    include Markdown

    module AssetDetailsConcern
      extend ActiveSupport::Concern

      included do
        has_many :asset_details, dependent: :destroy
        before_validation :cleanup_orphaned_asset_details
        before_validation :ensure_asset_details
      end

      def asset_details_count
        asset_details.count
      end

      private

      def cleanup_orphaned_asset_details
        asset_details.each do |asset_detail|
          asset_detail.destroy if asset_detail.asset.nil?
        end
      end

      def ensure_asset_details
        (assets - asset_details.all.map(&:asset)).map do |asset|
          build_asset_detail_for_asset(asset)
        end
      end

      def build_asset_detail_for_asset(asset)
        asset_details.build(asset: asset)
      end
    end

    include AssetDetailsConcern if respond_to?(:has_many_attached)
  end
end
