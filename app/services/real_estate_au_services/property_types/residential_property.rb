# frozen_string_literal: true

# Builds a ResidentialProperty object
# which is compatible with
# RealEstate.com.au
# See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
module RealEstateAuServices
  module PropertyTypes
    # Builds a ResidentialProperty object
    # which is compatible with
    # RealEstate.com.au
    # See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
    class ResidentialProperty
      include RealEstateAuServices::PropertyTypes::BaseProperty

      def tag_name
        'residential'
      end

      def property_elements(xml)
        # TODO Return the residential XML block
      end

      # [other farming development hotel warehouse medical offices retail_store showrooms house townhouse apartment villa land acreage rural]
      # https://partner.realestate.com.au/documentation/api/listings/elements/#category
      def category
        return nil if @property.usages.none?

        case @property.usages.first.underscore.to_sym
        when :house then              'House'
        when :unit then               'Unit'
        when :townhouse then          'Townhouse'
        when :villa then              'Villa'
        when :apartment then          'Apartment'
        when :flat then               'Flat'
        when :studio then             'Studio'
        when :serviced_apartment then 'ServicedApartment'
        when :other then              'Other'
        # Warehous
        # DuplexSemi-detache
        # Alpin
        # AcreageSemi-rura
        # Retiremen
        # BlockOfUnit
        # Terrace
        end
      end
    end
  end
end
