# frozen_string_literal: true

module RealEstateAuServices
  module Elements
    # The allowance element is available for Residential Rental property only and limited to set child elements, petFriendly, furnished and smokers. Child elements can be true/false.
    # https://partner.realestate.com.au/documentation/api/listings/elements/#allowances
    module Allowances
      def allowances(xml)
        xml.allowances {
          # xml.petFriendly
          # xml.furnished
          # xml.smokers
        }
      end
    end
  end
end
