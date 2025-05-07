# frozen_string_literal: true

module RealEstateAuServices
  module Elements
    # This element represents a text string describing the price of the listed property,
    # that can be displayed in place of the price element.
    # https://partner.realestate.com.au/documentation/api/listings/elements/#price
    module Price
      def price(xml)
        xml.price price_label
      end

      private

      # https://partner.realestate.com.au/documentation/api/listings/elements/#price
      # This element represents a text string describing the price of the listed property, that can be displayed in place of the price element.
      def price_label
        return nil unless @property.contract.present?

        if @property.contract.for_sale? && @property.contract.for_lease?
          number_with_precision(@property.contract.sale_actual_sale_price, precision: 0)
        elsif @property.contract.for_sale? # Only for_sale
          number_with_precision(@property.contract.sale_actual_sale_price, precision: 0)
        elsif @property.contract.for_lease? # Only for_lease
          number_with_precision(@property.contract.lease_gross_rent, precision: 2)
        end
      end
    end
  end
end
