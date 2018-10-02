module Universal
  module Concerns
    module Commentable

      extend ActiveSupport::Concern

      included do

        has_many :comments, class_name: 'Universal::Comment', as: :subject

        def save_comment!(content, user=nil, scope=nil)
          comment = self.comments.create  content: content,
                                          user: user,
                                          author: user.nil? ? nil : user.name,
                                          system_generated: true,
                                          when: Time.now.utc,
                                          scope: scope
          touch
        end

      end
    end
  end
end
