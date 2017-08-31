require_dependency "universal/application_controller"
module Universal
  class FlagsController < Universal::ApplicationController
  
    def create
      @model = params[:model_type].classify.constantize.find params[:model_id]
      if !@model.flagged_with?(:starred)
        @model.flag!(:starred)
      else
        @model.remove_flag!(:starred)
      end
      xhr?
    end

    def destroy
      @model = params[:model_type].classify.constantize.find params[:model_id]
      @model.remove_flag!(params[:id])
      xhr?
    end

    def toggle
      if !params[:model_type].blank? and !params[:model_id].blank?
        @model = params[:model_type].classify.constantize.find params[:model_id]
      elsif !params[:subject_type].blank? and !params[:subject_id].blank?
        @model = params[:subject_type].classify.constantize.find params[:subject_id]
      end
      if !@model.nil?
        if @model.flagged_with?(params[:flag])
          @add = false
          @model.remove_flag!(params[:flag])
          @model.log!("Flag removed: #{params[:flag].titleize}", current_user)
        else
          @add = true
          @model.flag!(params[:flag], current_user)
          @model.log!("Flag added: #{params[:flag].titleize}", current_user)
        end
      end
      xhr?
    end

  end
end