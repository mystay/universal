module Universal
  class Configuration
    DEFAULT_TEMPLATE_ENGINE  = :bootstrap
    DEFAULT_ICON_ENGINE      = :fontawesome

    cattr_accessor :template_engine, :icon_engine, :field_name_taggable, :field_name_tokened, :field_name_email_history, :numbered_scope_field

    def self.reset
      self.template_engine   = DEFAULT_TEMPLATE_ENGINE
      self.icon_engine       = DEFAULT_ICON_ENGINE
      
      self.field_name_taggable = :tags
      self.field_name_tokened = :_t
      self.field_name_email_history = :_eh
      
      self.numbered_scope_field = nil
      
    end

  end
end
Universal::Configuration.reset