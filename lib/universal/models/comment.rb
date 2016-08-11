module Universal
  module Models
    module Comment
      extend ActiveSupport::Concern

      included do
        include Mongoid::Document
        include Mongoid::Timestamps
        include Universal::Concerns::Polymorphic
        include Universal::Concerns::Kind
        include Universal::Concerns::Status
        store_in collection: 'comments'
        
        field :a, as: :author
        field :c, as: :content
        field :w, as: :when, type: DateTime
        field :sg, as: :system_generated, type: Boolean, default: false
        
        default_scope ->(){order_by(when: :asc)}
        
        if !Universal::Configuration.class_name_user.blank?
          belongs_to :user, class_name: Universal::Configuration.class_name_user, foreign_key: :user_id
        end
        
      end

      ####################################################################### ClassMethods
      module ClassMethods
      end
      ####################################################################### End ClassMethods

    end
  end
end