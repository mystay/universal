module Universal
  module Concerns
    module EmailHistory
      extend ActiveSupport::Concern

      included do
        field Universal::Configuration.field_name_email_history, as: :email_history, type: Array, default: []

        def add_email_history!(address, context=nil, time=Time.now.utc)
          self.push(Universal::Configuration.field_name_email_history => {e: address, w: time, c: context.to_s})
        end
      end

    end
  end
end