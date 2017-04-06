module Universal
  module Concerns
    module Addressed
      extend ActiveSupport::Concern
      
      included do
        include Universal::Concerns::BelongsToCountry
        include Universal::Concerns::Geocodable
        
        field :_ad1, as: :address_line_1
        field :_ad2, as: :address_line_2
        field :_adc, as: :address_city
        field :_ads, as: :address_state
        field :_adz, as: :address_post_code
        field :_afa, as: :address_formatted
        field :_apa, as: :postal_address
        
        before_save :update_formatted_address
        
        def address
          return {
            line_1: self.address_line_1,
            line_2: self.address_line_2,
            city: self.address_city,
            state: self.address_state,
            post_code: self.address_post_code,
            formatted: self.formatted_address,
            postal_address: self.postal_address,
            country_code: self.country_code,
            country_id: self.country_id.to_s
          }
        end
        
        def formatted_address
          if self.address_formatted.blank? 
            return self.parsed_address
          else
            return self.address_formatted
          end
        end
    
        def parsed_address
          return [
            (self.address_line_1.strip.blank? ? nil : self.address_line_1.strip), 
            (self.address_line_2.strip.blank? ? nil : self.address_line_2.strip),
            (self.address_city.strip.blank? ? nil : self.address_city.strip), 
            (self.address_state.strip.blank? ? nil : self.address_state.strip), 
            (self.address_post_code.strip.blank? ? nil : self.address_post_code.strip), 
            (self.country_code.strip.blank? ? nil : self.country_code.strip)
            ].compact.join(', ')
        end
        
        private
        def update_formatted_address
          if !self.new_record? and (self.address_line_1.blank? or self.address_line_1_changed? or self.address_line_2_changed? or self.address_city_changed? or self.address_state_changed?)
            self.address_formatted = self.parsed_address
          end
        end
      end
      
    end
  end
end