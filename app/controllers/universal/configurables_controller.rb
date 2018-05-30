require_dependency "universal/application_controller"

module Universal
  class ConfigurablesController < Universal::ApplicationController
    before_filter :find_model

    def create
      render json: {} and return false unless @model
      @model.set_config!  params[:key],
                          params[:value].encode('UTF-16le', invalid: :replace, replace: '').encode('UTF-8'),
                          (params[:environment].present? ? params[:environment] : nil),
                          nil,
                          params[:name]
      xhr?
    end

    def delete
      render json: {} and return false unless @model
      find_hash = {key: params[:key]}
      find_hash.merge!({environment: params[:environment]}) if params[:environment].present?
      key_value = @model.key_values.find_by(find_hash)
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
