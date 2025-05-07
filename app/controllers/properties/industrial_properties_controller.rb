module Properties
  class IndustrialPropertiesController < PropertiesController
    def new
      @property = IndustrialProperty.new(country: Current.country, state: Current.state)
    end

    private

    def scoped_properties
      agent_property_ids  = Current.agent.industrial_properties.pluck(:id)
      shared_property_ids = Current.account.industrial_properties.where(share: true).pluck(:id)
      Property.where(id: [agent_property_ids + shared_property_ids].uniq).includes(:contract)
    end

    def create_new_property_from_params
      @property = @current_agent.industrial_properties.new(property_params)
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:industrial_property)
            .permit(
              :agent_id,
              :brochure_description,
              :building,
              :city,
              :clear_span_columns,
              :country,
              :crane,
              :disability_access,
              :entrances_roller_doors_container_access,
              :estate,
              :fit_out,
              :floor_area,
              :floor_level,
              :floor,
              :furniture,
              :grabline,
              :hard_stand_yard_area,
              :headline,
              :internal_id,
              :keywords,
              :local_council,
              :land_area,
              :lifts_escalators_travelators,
              :max_clearance_height,
              :min_clearance_height,
              :name,
              :naming_rights_cost,
              :naming_rights,
              :notes,
              :office_area,
              :parking_comments,
              :parking_spaces,
              :postal_code,
              :production_area,
              :rating,
              :share,
              :showroom_area,
              :state,
              :storage_area,
              :street_name,
              :street_number,
              :unit_suite_shop,
              :trading_area,
              :type,
              :unique_space_deprecated,
              :warehouse_area,
              :website_description,
              :website_url,
              :zoning,
              usages: [],
              images: [],
              files: []
            )
    end
  end
end
