module Properties
  class DuplicatePropertiesController < ::ApplicationController
    before_action :authenticate_agent!
    before_action :set_property

    def create
      duplicate_property = PropertyServices::DuplicateProperty.new.duplicate_property(@property, @current_agent)

      if duplicate_property.duplicated?
        redirect_to [:edit, duplicate_property.property], notice: 'Property was successfully duplicated.', status: :see_other
      else
        redirect_to [:properties], notice: 'Error duplicating property.', status: :unprocessable_entity
      end
    end

    private

    def property_id
      params[:id]
    end

    def set_property
      @property = @current_agent.properties.with_archived.find(property_id)
    end
  end
end
