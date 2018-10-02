module Universal
  module Concerns
    module Archivable
      extend ActiveSupport::Concern
      included do
        field :_ach, as: :archived, type: Boolean, default: false

        default_scope ->(){where(archived: false)}
        scope :archived, ->(){where(archived: true)}
        scope :unarchived, ->(){where(archived: false)}
      end

      def archive!
        self.set(_ach: true)
        touch
      end

      def unarchive!
        self.set(_ach: false)
        touch
      end

    end
  end
end
