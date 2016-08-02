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
            self.update_attribute :functions, [function]
          else
            if on_off == 'false'
              self.pull(functions: function)
            else
              self.push(functions: function) if !self.has?(function)
            end
          end
        end
      end
        
      module ClassMethods
      end
    end
  end
end