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
          touch
        end

        def remove_employee!(employee)
          if !employee.nil? and employee.valid? and self.employee_ids.include?(employee.id)
            self.employments.where(employee: employee).destroy_all
          end
          touch
        end

      end

    end
  end
end
