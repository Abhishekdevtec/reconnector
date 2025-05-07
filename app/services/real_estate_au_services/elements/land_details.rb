# frozen_string_literal: true

module RealEstateAuServices
  module Elements
    # This is used to describe the physical attributes of the land being offered.
    # https://partner.realestate.com.au/documentation/api/listings/elements/#landdetails
    module LandDetails
      def land_details(xml)
        xml.landDetails do
          xml.area(unit: 'squareMeter') { xml.text land_area_label } if @property.land_area&.positive?
          # https://partner.realestate.com.au/documentation/api/listings/elements/#frontage
          # xml.frontage
          # xml.depth
          # xml.crossOver
        end
      end

      private

      def land_area_label
        number_with_precision(@property.land_area, precision: 0)
      end
    end
  end
end
