module Universal
  module Concerns
    module Contactable
      extend ActiveSupport::Concern
      
      included do
        field :_ctn, as: :contact_name
        field :_ctp, as: :contact_position
        field :_cte, as: :contact_email
        field :_cte2, as: :contact_email_2
        field :_phh, as: :phone_home
        field :_phw, as: :phone_work
        field :_phm, as: :phone_mobile
        field :_phf, as: :fax
      end
      
    end
  end
end