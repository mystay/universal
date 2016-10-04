module Universal
  module Concerns
    module Employee
      extend ActiveSupport::Concern

      included do
      
        has_many :employments, as: :employee, class_name: 'Universal::Employment'
        
        def employer_ids #this may span multiple employer_types
          self.employments.map{|e| e.employer_id}
        end
        
        def employers
          self.employments.map{|e| e.employer}
        end
        
      end
      
      module ClassMethods
        def employed_by(employers=[])
          employers.each do |employer|
            #eg: def companies
            define_method(employer.to_a[0][0].to_sym) do
              "::#{employer.to_a[0][1]}".classify.constantize.in(id: self.employer_ids).cache
            end
            #eg: def company_ids
            define_method("#{employer.to_a[0][0].to_s.singularize}_ids".to_sym) do
              "::#{employer.to_a[0][1]}".classify.constantize.in(id: self.employer_ids).cache.map(&:id)
            end

            #colleagues - find other users from all employers
#             define_method("#{employer.to_a[0][0].to_s.singularize}_colleagues".to_sym){
#               employee_ids = []
#               employers = "::#{employer.to_a[0][1]}".classify.constantize.where(employments: {'$elemMatch' => {'user_id' => self.id, '_ach' => false}}).cache
#               return [] if employers.nil?
#               employers.map{|o| o.employments.map{|e| employee_ids.push(e.user_id)} if !o.employments.nil?}
#               return ::Padlock::User.in(id: employee_ids.uniq).cache
#             }
          end
        end
      end
    end
  end
end