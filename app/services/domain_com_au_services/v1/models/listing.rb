# frozen_string_literal: true

# See https://developer.domain.com.au/docs/v1/getting-started
module DomainComAuServices
  module V1
    module Models
      class Listing
        # Builds a Property object
        # which is compatible with
        # Domain.com.au
        # See :
        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertbusinesslisting
        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertcommerciallisting
        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertresidentiallisting
        def self.create(property)
          case property.type
          when 'CommercialProperty' then DomainComAuServices::V1::Models::CommercialListing.new(property)
          when 'IndustrialProperty' then DomainComAuServices::V1::Models::CommercialListing.new(property)
          when 'ResidentialProperty' then DomainComAuServices::V1::Models::ResidentialListing.new(property)
          when 'RetailProperty' then DomainComAuServices::V1::Models::CommercialListing.new(property)
          else DomainComAuServices::V1::Models::NilListing.new(property)
          end
        end
      end
    end
  end
end
