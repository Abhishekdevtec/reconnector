# frozen_string_literal: true

module PropertyServices
  module Listings
    module DomainComAu
      class Destroyer
        # Allows the app to asynchronously destroy
        # a listing to CommercialRealEstate.com.au
        # using their Domain.com API
        def destroy_listing(property_id)
          PropertyJobs::Listings::DomainComAu::DestroyListingJob.perform_later(property_id)
        end

        # Our asynchronous job calls this method
        def destroy(property)
          listing_params = params(property)
          destroy_listing_service = DomainComAuServices::DestroyListing.new(listing_params)
          result = destroy_listing_service.destroy_listing

          if result.success?
            # Remove the Domain.com.au listing ID
            property.update_column(:domain_com_au_listing_id, nil)
            property.update_column(:domain_com_au_listed, false)
            property.activity_logs.create(account: property.account, agent: property.agent, action: 'removed_domain_com_au_listing', result: 'success', payload: result.response)
          else
            add_error_to_activity_log(property, result)
          end
          result
        end

        private

        def params(property)
          {
            access_token: property.account.domain_com_au_access_token,
            listing_id: property.domain_com_au_listing_id
          }
        end

        def add_error_to_activity_log(property, result)
          property.activity_logs.create(
            account: property.account,
            agent: property.agent,
            action: 'removed_domain_com_au_listing',
            result: 'failure',
            payload: result.response,
            body: result.response
          )
        end
      end
    end
  end
end
