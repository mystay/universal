module Universal
  module Concerns
    module Tokened
      extend ActiveSupport::Concern

      included do

        field Universal::Configuration.field_name_tokened, as: :token, type: String

        before_save :create_token

        index({Universal::Configuration.field_name_tokened => 1})

        def create_token(length=nil)
          if self.token.blank?
            if length.nil?
              self.token = SecureRandom.urlsafe_base64(10, false)
            else
              self.token = [*('A'..'Z')].sample(length).join
            end
          end
        end

      end

    end
  end
end