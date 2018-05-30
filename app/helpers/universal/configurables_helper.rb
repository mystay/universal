module Universal
  module ConfigurablesHelper
    def easy_config(model, environment=nil, section=nil)
      keys = UNIVERSAL_CONFIGS[model.class.name.demodulize.to_s.underscore.downcase.to_sym]
      if keys and !section.blank?
        keys = keys[section.to_s.downcase.underscore]
      end
      render partial: '/universal/configurables/easy_config',
        locals: {model: model, keys: keys, environment: environment}
    end
  end
end
