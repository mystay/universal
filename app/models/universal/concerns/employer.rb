module Universal
  module Concerns
    module Employer
      extend ActiveSupport::Concern

      included do
        has_many :employments, as: :employer, class_name: 'Universal::Employment'

        def employee_ids
          self.employments.map{|e| e.employee_id}.compact
        end

        def employees
          self.employments.map{|e| e.employee}
        end

        def add_employee!(employee)
          if !employee.nil? and employee.valid? and !self.employee_ids.include?(employee.id)
            self.employments.create employee: employee
          end
        end

      end

      module ClassMethods
#         def employed_by(employers=[])
#           employers.each do |employer|
#             define_method(employer.to_a[0][0].to_sym) { "::#{employer.to_a[0][1]}".classify.constantize.where(employments: {'$elemMatch' => {user_id: self.id, archived: false}}).cache }
#             define_method("#{employer.to_a[0][0].to_s.singularize}_ids".to_sym) { "::#{employer.to_a[0][1]}".classify.constantize.where(employments: {'$elemMatch' => {user_id: self.id, archived: false}}).cache.map(&:id) }

#             #office_colleagues
#             define_method("#{employer.to_a[0][0].to_s.singularize}_colleagues".to_sym){::Padlock::User.in(place_ids: self.office_ids).cache}
#           end
#         end
      end
    
    end
  end
end