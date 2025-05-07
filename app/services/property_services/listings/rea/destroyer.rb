# frozen_string_literal: true

module PropertyServices
  module Listings
    module Rea
      class Destroyer
        # Allows the app to asynchronously destroy
        # a listing to RealEstate.com.au
        def destroy_listing(property_id)
          PropertyJobs::Listings::Rea::DestroyListingJob.perform_later(property_id)
        end

        # Our asynchronous job calls this method
        def destroy(property)
          listing_params = params(property)
          rea = RealEstateAuServices::DestroyListing.new(listing_params)
          result = rea.destroy_listing

          if result.success?
            # RealEstate.com.au returns a unique Listing ID
            # which we need to associate with the property
            # for future API interaction with this property
            property.update_column(:rea_listing_id, result.upload_id)
            property.activity_logs.create(account: property.account, agent: property.agent, action: 'removed_rea_listing', result: 'success', payload: result.response)
          else
            add_error_to_activity_log(property, error)
            result
          end
        end

        private

        def params(property)
          {
            payload: RealEstateAuServices::Property.create(property).destroy_listing_as_xml,
            client_id: property.account.rea_client_id,
            client_secret: property.account.rea_client_secret
            # client_id: Rails.application.credentials.rea[:client_id],
            # client_secret: Rails.application.credentials.rea[:client_secret]
          }
        end

        def add_error_to_activity_log(property, result)
          property.activity_logs.create(
            account: property.account,
            agent: property.agent,
            action: 'removed_rea_listing',
            result: 'failure',
            payload: result.response,
            body: result.response
          )
        end
      end
    end
  end
end
