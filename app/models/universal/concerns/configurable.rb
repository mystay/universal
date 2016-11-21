module Universal
  module Concerns
    module Configurable

      extend ActiveSupport::Concern

      included do
        embeds_many :key_values, class_name: 'Universal::KeyValue'

        scope :matching_config, ->(key, value, context=nil){
          where(key_values: 
            (context.blank? ? {'$elemMatch' => {k: key.to_s, v: value.to_s}} : {'$elemMatch' => {c: context.to_s, k: key.to_s, v: value.to_s}}))
        }

        def config_value(key='', context=nil)
          if !context.blank?
            key_value = self.key_values.find_by(context: context.to_s, key: key.to_s)
          else
            key_value = self.key_values.find_by(key: key.to_s)
          end
          return key_value.value if !key_value.nil?
          nil
        end

        #for boolean configs
        def has_config?(key='', context=nil)
          self.config_value(key,context).to_s == 'true'
        end

        def set_config!(key='', value='', context=nil, name=nil)
          if context.nil?
            key_value = self.key_values.find_by(key: key.to_s)
          else
            key_value = self.key_values.find_by(context: context.to_s, key: key.to_s)
          end
          if !key_value.nil?
            if value.blank?
              key_value.destroy
            else
              key_value.set v: value.to_s
            end
          elsif !key.blank?
            self.key_values.create  context: context.blank? ? nil : context.to_s,
                                    key: key.blank? ? nil : key.to_s,
                                    value: value.blank? ? nil : value.to_s,
                                    name: name.blank? ? nil :name.to_s 
          end
          self.updated_config!(key)
        end

        def updated_config!(key)
          #placeholder method, can be overwritten in the model if need be
        end

      end

      module ClassMethods
      end

    end
  end
end