module Console
  module Properties
    class CommercialPropertiesController < PropertiesController
      def new
        @property = CommercialProperty.new
      end

      private

      def create_new_property_from_params
        @property = @agent.commercial_properties.new(property_params)
      end

      # Only allow a list of trusted parameters through.
      def property_params
        params.require(:commercial_property).permit(:type, :agent_id, :internal_id, :unique_space_deprecated, :floor_level, :name, :building, :naming_rights, :naming_rights_cost_cents, :estate, :unit_suite_shop, :floor, :street_number, :street_name, :state, :city, :postal_code, :country, :type, :office_area, :warehouse_area, :showroom_area, :storage_area, :production_area, :trading_area, :land_area, :hard_stand_yard_area, :floor_area, :headline, :grabline, :keywords, :brochure_description, :website_description, :parking_spaces, :parking_comments, :fit_out, :furniture, :lifts_escalators_travelators, :min_clearance_height, :max_clearance_height, :clear_span_columns, :crane, :entrances_roller_doors_container_access, :zoning, :disability_access, :rating, usages: [])
      end
    end
  end
end