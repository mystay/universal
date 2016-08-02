module Universal
  module Concerns
    module Orderable
      extend ActiveSupport::Concern

      included do
        field :_sq, as: :sequence, type: Integer, default: 999

        default_scope ->(){order_by(sequence: :asc)}

      end

    end
  end
end