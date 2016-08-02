require_dependency "universal/application_controller"

module Universal
  class ConfigurablesController < Universal::ApplicationController
    before_filter :find_model

    def create
      @model.set_config!(params[:key], params[:value], nil, params[:name]) if @model
      #log it
      if !@model.reflect_on_association(:logs).nil? and @model.class != Basement::Territory and @model.class != Lobby::Place
        @model.log!("Config updated: #{params[:key].titleize} > #{params[:value]}".to_s, current_user)
      end
      xhr?
    end

    def delete
      key_value = @model.key_values.find_by(key: params[:key])
      key_value.destroy if !key_value.nil?
      xhr?
    end

    private
    def find_model
      if !params[:model_class].blank? and !params[:model_id].blank?
        @model = params[:model_class].classify.constantize.where(id: params[:model_id]).first
      end
    end
  end
end
