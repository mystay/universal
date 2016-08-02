module Universal
  module Concerns
    module Commentable

      extend ActiveSupport::Concern

      included do
        
        has_many :comments, class_name: 'Universal::Comment', as: :subject
        
        def save_comment!(content, author)
          comment = self.comments.create  content: content,
                                          user: user,
                                          author: user,
                                          system_generated: true
        end

      end
    end
  end
end