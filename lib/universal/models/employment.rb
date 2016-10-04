module Universal
  module Models
    module Employment
      extend ActiveSupport::Concern
      
      included do
        include Mongoid::Document
        include Universal::Concerns::Status
        include Universal::Concerns::Commentable
        include Universal::Concerns::Taggable
        
        field :start_date, type: Date
        field :notes
        
        belongs_to :employer, polymorphic: true
        belongs_to :employee, polymorphic: true
        
        statuses %w(current past archived), default: :current
        
      end
    end
  end
end