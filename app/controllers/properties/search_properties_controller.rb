module Properties
  class SearchPropertiesController < PropertiesController
    private

    def scoped_properties
      @current_agent.properties.search(search_param)
    end

    def search_param
      params[:search]
    end
  end
end
