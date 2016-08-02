module Universal
  module Concerns
    module Kind
      extend ActiveSupport::Concern

      included do
        #add the mongoid field
        field :_kn, as: :kind, type: String
        scope :for_kind, ->(kind){where(kind: kind.to_s)} #for undefined kinds
        scope :for_kinds, ->(kinds){where(:kind.in => kinds.map{|k| k.to_s})} #for undefined kinds
      end

      module ClassMethods
        def kinds(kind_array=[], default_kind=nil)

          field(:_kn, as: :kind, type: String, default: default_kind, overwrite: true) if !default_kind.nil?

          const_set("Kinds", kind_array.map{|a| a.to_s})

          kind_array.each do |name|
            #pending?
            define_method("#{name}?") { self.read_attribute(:kind) == name.to_s }
            #scopes
            scope name.to_sym, ->(){where('$and' => [{kind: name.to_s}])}
            scope "not_#{name}".to_sym, ->(){where('$and' => [{:kind.ne => name.to_s}])}
          end
        end
      end

    end
  end
end