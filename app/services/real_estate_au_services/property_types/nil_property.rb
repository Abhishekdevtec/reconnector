# frozen_string_literal: true

# Builds a CommercialProperty object
# which is compatible with
# RealEstate.com.au
# See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
module RealEstateAuServices
  module PropertyTypes
    class NilProperty < RealEstateAuServices::Property
      def property_elements(_xml)
        raise 'NotImplemented'
      end
    end
  end
end
