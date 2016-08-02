module Universal
  module Concerns
    module Polymorphic
      extend ActiveSupport::Concern

      included do
        belongs_to :subject, polymorphic: true

        index subject_type: 1
        index subject_id: 1

        scope :for_subject, ->(subject){where(subject_type: subject.class.to_s, subject_id: subject.id)}
      end

    end
  end
end