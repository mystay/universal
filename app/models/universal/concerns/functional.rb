module Universal
  module Concerns
    module Functional
      extend ActiveSupport::Concern

      included do
        field :functions, type: Array

        def has?(function)
          self.functions and self.functions.include?(function.to_s)
        end

        def set_function!(function, on_off)
          if self.functions.nil?
            self.update functions: [function.to_s]
          else
            if on_off.to_s == 'false'
              self.pull(functions: function.to_s)
            else
              self.push(functions: function.to_s) if !self.has?(function.to_s)
            end
          end
          touch
        end
      end

    end
  end
end
