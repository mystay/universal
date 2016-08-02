module Universal
  module Concerns
    module Permalinked
      extend ActiveSupport::Concern

      included do
        field :_pml, as: :permalink, type: String

        before_validation :set_permalink
        scope :for_permalink, ->(permalink){where(permalink: permalink)}
      end

      module ClassMethods
        def permalink(s)
          define_method("set_permalink"){
            p = self.permalink
            p = self.read_attribute(s.to_sym) if p.blank?
            p = p.gsub("'",'').parameterize
            #make sure there's no matching permalink:
            self.permalink = p
          }
        end
      end
    end
  end
end