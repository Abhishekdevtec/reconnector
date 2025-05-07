# frozen_string_literal: true

module AquityV2Services
  module Builders
    module Units
      def units
        @units ||= build_units
      end

      def find_unit_by_id(id)
        units.select { |t| t.id == id }.first
      end

      def unit_types
        @unit_types ||= AquityV2::UnitType.from_table_data(data_table(:unit_type))
      end

      def find_unit_type_by_id(id)
        unit_types.select { |t| t.id == id }.first
      end

      private

      def build_units
        arr = AquityV2::Unit.from_table_data(data_table(:unit))
        arr.each do |item|
          item.unit_type = find_unit_type_by_id(item.id)
        end
        arr
      end
    end
  end
end
