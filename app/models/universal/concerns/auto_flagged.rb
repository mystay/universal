#INCOMPLETE - No model setup yet
module Universal
  module Concerns
    module AutoFlagged
      extend ActiveSupport::Concern
      included do
        has_many :auto_flags, as: :subject, class_name: 'Base::AutoFlag'
        
      end
    end
  end
end