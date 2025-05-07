module Properties
  class ArchivedPropertiesController < PropertiesController
    def index
      @pagy, @properties = pagy(scoped_properties)
    end

    private

    def scoped_properties
      @current_agent.properties.only_archived.includes(:contract)
    end
  end
end
