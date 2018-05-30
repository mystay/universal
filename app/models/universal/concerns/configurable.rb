module Universal
  module Concerns
    module Configurable

      extend ActiveSupport::Concern

      included do
        embeds_many :key_values, class_name: 'Universal::KeyValue'

        scope :matching_config, lambda{|key, value, context=nil, environment=nil|
          environment = nil if environment.to_s=='production'
          hash = {k: key.to_s, v: value.to_s}
          hash.merge!({c: context.to_s}) if context.present?
          hash.merge!({e: environment.to_s})
          where(key_values: {'$elemMatch' => hash})
        }

        def config_value(key='', context=nil, environment=Rails.env, utf_escape=true)
          find_hash = {key: key.to_s}
          find_hash.merge!({context: context.to_s}) if context.present?
          find_hash_env = find_hash.merge({environment: environment})
          key_value = self.key_values.find_by(find_hash_env) # find by key/context/environment first
          key_value ||= self.key_values.find_by(find_hash) if environment==Rails.env # fall back to just key/context
          if utf_escape
            return key_value.value.to_s.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '') if key_value
          else
            return key_value.value.to_s if key_value
          end
          nil
        end

        #for boolean configs
        def has_config?(key='', context=nil, environment=nil)
          self.config_value(key, context, environment).to_s == 'true'
        end

        def set_config!(key='', value='', environment=Rails.env, context=nil, name=nil)
          find_hash = {key: key.to_s}
          find_hash.merge!({context: context.to_s}) if context.present?
          find_hash.merge!({environment: environment.to_s}) if environment.present?
          key_value = self.key_values.find_by(find_hash)
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
                                    name: name.blank? ? nil :name.to_s,
                                    environment: environment.blank? ? nil : environment.to_s
          end
          self.updated_config!(key)
        end

        def updated_config!(key)
          #placeholder method, can be overwritten in the model if need be
        end

      end

    end
  end
end
