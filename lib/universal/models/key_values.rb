module Universal
  module Models
    module KeyValue
      extend ActiveSupport::Concern

      included do
        include Mongoid::Document

        field :c, as: :context
        field :k, as: :key
        field :n, as: :name
        field :v, as: :value
        field :e, as: :environment, default: nil

#         validates :key, presence: true

        embedded_in :model
      end

      ####################################################################### ClassMethods
      module ClassMethods
      end
      ####################################################################### End ClassMethods

    end
  end
end
