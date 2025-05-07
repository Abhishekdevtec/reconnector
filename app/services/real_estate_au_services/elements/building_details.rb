# frozen_string_literal: true

module RealEstateAuServices
  module Elements
    # This element contains information about the physical structure of the building for sale or rent.
    # The sub element Area is displayed on site as Floor Area.
    # https://partner.realestate.com.au/documentation/api/listings/elements/#buildingdetails
    module BuildingDetails
      def building_details(xml)
        xml.buildingDetails do
          xml.area(unit: 'squareMeter') { xml.text building_area_label } if @property.building_area&.positive?
          # xml.energyRating
        end
      end

      private

      def building_area_label
        number_with_precision(@property.building_area, precision: 0)
      end
    end
  end
end
