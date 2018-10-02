module Universal
  module Concerns
    module Geocodable
      extend ActiveSupport::Concern

      included do
        include Geocoder::Model::Mongoid

        field :_cd, as: :coordinates, type: Array #[lat/lng]

        index({ _cd: "2d" }, { min: -200, max: 200 })

        geocoded_by :formatted_address
        after_update :update_geocode

        def update_geocode(force=false)
          if !self.formatted_address.to_s.delete(',').strip.blank? and
            (self.coordinates.blank? or force or self.address_line_1_changed? or self.address_formatted_changed?)
            old_coods = self.coordinates
            new_coords = self.geocode
            if !new_coords.blank?
              new_coords = new_coords.reverse
              if new_coords != old_coods
                self.set(_cd: new_coords)
                touch
              else
                logger.debug "coords haven't changed"
              end
            else
              puts "*** An error occurred retrieving the coordinates for #{self.class.name} #{self.id} - #{self.formatted_address}"
            end
          end
          touch
        end

      end
    end
  end
end
