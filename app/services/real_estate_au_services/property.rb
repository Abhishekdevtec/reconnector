# frozen_string_literal: true

# Builds a Property object
# which is compatible with
# RealEstate.com.au
# See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements
module RealEstateAuServices
  class Property
    def self.create(property)
      case property.type
      when 'CommercialProperty' then RealEstateAuServices::PropertyTypes::CommercialProperty.new(property)
      when 'IndustrialProperty' then RealEstateAuServices::PropertyTypes::CommercialProperty.new(property)
      when 'ResidentialProperty' then RealEstateAuServices::PropertyTypes::ResidentialProperty.new(property)
      when 'RetailProperty' then RealEstateAuServices::PropertyTypes::CommercialProperty.new(property)
      else RealEstateAuServices::PropertyTypes::NilProperty.new(property)
      end
    end
  end
end
