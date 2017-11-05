module Ecm::Blog
  class Post < ActiveRecord::Base
    include Model::Ecm::Comments::CommentableConcern
    include Model::Ecm::Tags::TaggableConcern

    # acts as published
    include ActsAsPublished::ActiveRecord
    acts_as_published

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
  end
end
