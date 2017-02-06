require_dependency "universal/application_controller"
module Universal
  class CountriesController < Universal::ApplicationController
  
    def index
      render json: {countries: Universal::Country.all.map{|c| c.to_json}}
    end
    
  end
end