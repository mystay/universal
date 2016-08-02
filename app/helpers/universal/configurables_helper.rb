module Universal
  module ConfigurablesHelper
    def easy_config(model, section=nil)
      #logger.debug model.class.name.demodulize.to_s.downcase.to_sym
      keys = UNIVERSAL_CONFIGS[model.class.name.demodulize.to_s.underscore.downcase.to_sym]
      #logger.debug keys
      if keys and !section.blank?
        keys = keys[section.to_s.downcase.underscore]
      end
      puts keys
      render partial: '/universal/configurables/easy_config', locals: {model: model, keys: keys}
    end
  end
end
