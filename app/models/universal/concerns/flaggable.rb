module Universal
  module Concerns
    module Flaggable
      extend ActiveSupport::Concern
      included do
        field :_fgs, as: :flags, type: Array, default: []
        field :_fgh, as: :flag_history, type: Array, default: []
        scope :flagged_with, ->(flag){where(flags: flag)}
      end

      #can be passed as a string or an array, either way, convert it to an array of strings
      def flag!(f=[], user=nil, record_history=false)
        f = [f.to_s] if f.class != Array
        f = f.map{|flag| flag.to_s}
    #     puts "#---------------#{self.flags}"
        if self.flags.nil?
          self.set(_fgs: f)
        else
          f.each do |flag|
            self.push(_fgs: flag) if !self.flags.include?(flag)
          end
        end
    #     logger.debug "Flagged with '#{f.join(', ')}'"
        if record_history
          #update the flag history
          history = f.map{|flag| {f: flag, w: Time.now, un: (user.nil? ? nil : user.name), user_id: (user.nil? ? nil : user.id)}}
          if self.flag_history.nil?
            self.set(:_fgh => history)
          else
            history.each do |h|
              self.push(:_fgh => h)
            end
          end
        end
        touch
      end

      def remove_flag!(f)
        f = [f.to_s] if f.class != Array
        f = f.map{|flag| flag.to_s}
        f.each do |flag|
          self.pull(_fgs: flag) if self.flags.include?(flag)
        end
        touch
      end

      def flagged_with?(f)
        !self.flags.nil? and self.flags.include?(f.to_s)
      end

      def clear_flags!
        self.unset(:_fgs)
        touch
      end

      def flag_history_records(code)
        self.flag_history.select{|c| c['f'].to_s == code.to_s}
      end

      module ClassMethods
        def flags(flag_array=[])
          const_set("Flags", flag_array.map{|a| a.to_s})

          flag_array.each do |name|
            define_method("#{name}?") do
              self.read_attribute(:_fgs).nil? ? nil : self.read_attribute(:_fgs).include?(name.to_s)
            end
            define_method("#{name}!") do
              self.flag!(name.to_sym)
            end

            #scopes
            scope name.to_sym, ->(){where('$and' => [{flags: name.to_s}])}
            scope "not_#{name}".to_sym, ->(){where('$and' => [{:flags.ne => name.to_s}])}

          end

        end
      end
    end
  end
end
