module Universal
  module Models
    module Attachment
      extend ActiveSupport::Concern  
      require 'carrierwave/mongoid'
      
      included do
        include Mongoid::Document
        include Mongoid::Timestamps
        include Universal::Concerns::Taggable
        include Universal::Concerns::Commentable
        include Universal::Concerns::Kind
        include Universal::Concerns::Polymorphic
        include Universal::Concerns::Trashable
        
        field :n, as: :name
        field :no, as: :notes
        field :surl, as: :shortened_url
        field :tci, as: :temporary_comment_id
        
        mount_uploader :file, Universal::FileUploader
        
        validates_presence_of :file
        scope :for_comment, -> (c){where(tci: c)}
        scope :for_name, ->(n){where(name: n)}
        scope :recent, ->(){order_by(created_at: :desc)}
        
        def image?
          %w(.png .jpg .gif).any?{ |file_type| self.file_filename.include?(file_type) }
        end
        
        def title
          self.name.blank? ? self.file_filename : self.name
        end
        
        def to_json
          {
            id: self.id.to_s,
            name: self.name,
            file: self.file_filename,
            url: self.file.url,
            created_at: self.created_at,
            shortened_url: self.shortened_url,
            subject_type: self.subject_type,
            subject_id: self.subject_id,
            subject_name: self.subject.name,
            created_formatted: self.created_at.strftime('%b %d, %Y'),
            image: self.image?,
            temp_comment_id: self.tci
          }
        end
        
      end
      
    end
  end
end
