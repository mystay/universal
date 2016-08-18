module Universal
  module Concerns
    module Numbered
      extend ActiveSupport::Concern

      included do

        field :_num, as: :number #all models get a default number

        before_validation :generate_number!#, on: :save

        private
        def generate_number!
          if self.number.blank?
            if !::Universal::Configuration.numbered_scope_field.blank?
              scope = self[::Universal::Configuration.numbered_scope_field]
            else
              scope=nil
            end
            
            num = ::Universal::DocumentNumber.generate!(self.class.to_s, self.class.name.demodulize.underscore.to_s[0,1], scope.to_s)
            self.number = num
          end
        end
      end

      module ClassMethods
        
        def extra_numbers(number_array, default_kind=nil)
          
          number_array.each_with_index do |num, i|
            field "_num#{i}".to_sym, as: num.to_sym
          end

        end
      end
    end
  end
end