module Universal
  module Concerns
    module HasAttachments
      extend ActiveSupport::Concern

      included do
        
        has_many :attachments, as: :subject, class_name: 'Universal::Attachment'

      end

    end
  end
end