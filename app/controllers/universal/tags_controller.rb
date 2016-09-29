require_dependency "universal/application_controller"

module Universal
  class TagsController < Universal::ApplicationController
    
    def index
      @model = params[:model_class].classify.constantize.find params[:model_id]
      render json: @model.tags.to_json
    end

    def create
      @model = params[:model_class].classify.constantize.find params[:model_id]
      tags = params[:tags].split(',').map{|t| t.strip.parameterize if !t.strip.blank?}.compact
      @model.update(tags: tags)
      xhr?
    end
    
  end
end