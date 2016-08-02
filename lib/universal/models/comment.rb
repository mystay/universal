module Universal
  module Models
    module Comment
      extend ActiveSupport::Concern

      included do
        include Mongoid::Document
        include Mongoid::Timestamps
        include Universal::Concerns::Polymorphic, Universal::Concerns::Kind, Universal::Concerns::Status
        store_in collection: 'comments'
        
        field :a, as: :author
        field :c, as: :content
        field :w, as: :when, type: DateTime
        field :sg, as: :system_generated, type: Boolean, default: false
        
        default_scope ->(){order_by(when: :asc)}
        
      end

      ####################################################################### ClassMethods
      module ClassMethods
      end
      ####################################################################### End ClassMethods

    end
  end
end