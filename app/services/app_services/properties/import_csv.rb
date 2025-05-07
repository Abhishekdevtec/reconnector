# frozen_string_literal: true

require 'csv'

# Service which imports a property CSV file
module AppServices
  module Properties
    class ImportCsv
      def initialize(filename, agent_id)
        @filename = filename
        @agent_id = agent_id
      end

      def call
        csv = CSV.parse(csv_content, encoding: 'UTF-8', headers: true, col_sep: ';')
        csv.each do |row|
          create_property!(row)
        # rescue StandardError => e
        #   p e.full_message
        #   p row
        end
      end

      private

      def create_property!(row)
        property = case row['type']
                   when 'Commercial'
                     CommercialProperty.new
                   when 'Industrial'
                     IndustrialProperty.new
                   when 'Residential'
                     ResidentialProperty.new
                   when 'Retail'
                     RetailProperty.new
                   end
        property.agent = agent
        property.usages = row['usages'].split(' ') if row['usages'].present?
        property_attributes.each do |attribute|
          property.public_send("#{attribute}=", row[attribute]) if row[attribute].present?
        end
        PropertyServices::CreateProperty.new.create_property(property)
      end

      def csv_content
        File.read(@filename)
      end

      def agent
        @agent ||= Agent.find(@agent_id)
      end

      def property_attributes
        %w(archived_at brochure_description building city clear_span_columns country crane disability_access entrances_roller_doors_container_access estate fit_out floor floor_area floor_level furniture grabline hard_stand_yard_area hard_stand_yard_description headline keywords land_area land_area_description lifts_escalators_travelators local_council lot_number max_clearance_height min_clearance_height name naming_rights naming_rights_cost_cents notes office_area parking_comments parking_spaces postal_code production_area rating showroom_area state storage_area street_name street_number trading_area unit_suite_shop warehouse_area website_description website_url zoning)
      end
    end
  end
end
