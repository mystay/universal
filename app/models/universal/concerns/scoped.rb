module Universal
  module Concerns
    module Scoped
      extend ActiveSupport::Concern
      included do
        prepare_scope
      end
      
      module ClassMethods
        def prepare_scope
          if !UniversalCrm::Configuration.scope_class.blank?  
            belongs_to :scope, polymorphic: true
            scope :scoped_to, ->(model){where(scope_id: (model.nil? ? nil : model.id), scope_type: (model.nil? ? nil : model.class))}
            
          end
        end
      end
      
    end
  end
end