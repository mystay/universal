module Universal
  module Concerns
    module Status
      extend ActiveSupport::Concern

      included do
      end

      module ClassMethods
        #possible options: :default (symbol), :multiple (true/false)
        def statuses(status_array=[], options={})
          const_set("Statuses", status_array.map{|a| a.to_s})

          field(:_s, as: :status, type: String, default: options[:default].blank? ? nil : options[:default].to_s)
          if options[:multiple]
            field(:_ss, as: :statuses, type: Array, default: options[:default].blank? ? nil : [{'s' => options[:default].to_s}])
          end

          scope :for_status, ->(status){where('$and' => [{status: status.to_s}])} #for undefined statuss

          status_array.each do |name|
            if name.to_s.downcase == 'new'
              raise "Error: You cannot have a status named 'new'. Please change the 'statuses' declaration in the #{self} Class."
            elsif name.to_s.downcase == 'valid'
              raise "Error: You cannot have a status named 'valid'. Please change the 'statuses' declaration in the #{self} Class."
            end

            #pending?
            define_method("#{name}?") { self.read_attribute(:_s) == name.to_s }

            #scopes
            scope name.to_sym, ->(){where('$and' => [{status: name.to_s}])}
            scope "not_#{name}".to_sym, ->(){where('$and' => [{:status.ne => name.to_s}])}

            #This will record the current status, as well as the status history that this model has been through
            if options[:multiple]
              scope "been_#{name}".to_sym, ->(){where('_ss.s' => name.to_s)}
              #model.been_pending? - Checks the status history to see if this is in there.
              define_method("been_#{name}?") { self.read_attribute(:_ss).select{|s| s['s'].to_s == name.to_s}.length>0 }
              #pending!
              define_method("#{name}!"){
                self.set(_s: name.to_s) #update the current status
                self.push(_ss: {s: name.to_s, w: Time.now}) #push to the list of all statuses this model has been
              }
            else
              #pending!
              define_method("#{name}!") { self.set(_s: name.to_s) }
            end
          end

        end
      end

    end
  end
end