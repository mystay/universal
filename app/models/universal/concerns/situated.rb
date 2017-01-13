module Universal
  module Concerns
    module Situated
      extend ActiveSupport::Concern

      included do
        has_many :situations, as: :subject, class_name: 'Universal::Situation'
        
      end
      
    end
  end
end