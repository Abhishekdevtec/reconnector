# frozen_string_literal: true

# Job which gets the property "ad_id" or property_id
# from Domain.com.au. The property ID is generated once
# the property has been uploaded to Domain AND processed.
module DomainComAu
  # This class will poll the Domain.com.au API and
  # see if the property has an AdId.
  #
  # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_getlistingreport
  class FetchListingIdJob < ApplicationJob
    queue_as :default

    retry_on AppServices::DomainComAu::FetchListingAdId::UnprocessedListingError, wait: 2.minutes, attempts: 5

    def perform(property_id)
      Rails.logger.info("[#{self.class}.perform] called with property_id: #{property_id}")
      AppServices::DomainComAu::FetchListingAdId.new(property_id).fetch_listing_ad_id
    end
  end
end
