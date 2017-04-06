module Universal
  module Concerns
    module BelongsToCountry
      extend ActiveSupport::Concern
    
      included do
    
        field :_cc, as: :country_code, type: String
    
        belongs_to :country, class_name: 'Universal::Country'
    
        scope :for_country, ->(country){where(country_id: country.class == String ? country : country.id)}
        
        before_save :update_country
    
        private
        def update_country
          self.country_code = self.country.code if !self.country_id.blank? and (self.country_code.blank? or self.country_id_changed?) and !self.country.nil?
        end
    
      end
    end
  end
end