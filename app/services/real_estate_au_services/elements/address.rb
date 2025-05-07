# frozen_string_literal: true

module RealEstateAuServices
  module Elements
    module Address
      # https://partner.realestate.com.au/documentation/api/listings/elements/#address
      def address(xml)
        xml.address(display: display_address, streetview: streetview) {
          xml.subNumber @property.unit_suite_shop if @property.unit_suite_shop.present?
          # xml.lotNumber
          # xml.site
          xml.streetNumber @property.street_number if @property.street_number.present?
          xml.street @property.street_name if @property.street_name.present?
          xml.suburb @property.city if @property.city.present?
          xml.state @property.state if @property.state.present?
          xml.postcode @property.postal_code if @property.postal_code.present?
          xml.country @property.country if @property.country.present?
        }
      end

      private

      def display_address
        'no'
      end

      def streetview
        'no'
      end
    end
  end
end
