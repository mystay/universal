require_dependency "universal/application_controller"

module Universal
  class TagsController < Universal::ApplicationController
    
    def index
      @model = params[:model_class].classify.constantize.find params[:model_id]
      render json: @model.tags.to_json
    end

    def create
      @model = params[:model_class].classify.constantize.find params[:model_id]
      tags = params[:tags].to_s.split(',').map{|t| t.strip}
      @model.update_attribute(:tags, tags)
      xhr?
    end
    
  end
end