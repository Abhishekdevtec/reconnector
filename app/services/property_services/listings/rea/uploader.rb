# frozen_string_literal: true

module PropertyServices
  module Listings
    module Rea
      class Uploader
        # Allows the app to asynchronously upload
        # a property to RealEstate.com.au
        def upload_listing(property_id)
          #PropertyJobs::Export::ReaUploadListingJob.perform_later(property_id)
          PropertyJobs::Listings::Rea::UploadListingJob.perform_later(property_id)
        end

        # Our asynchronous job calls this method
        def upload(property)
          listing_params = params(property)
          rea = RealEstateAuServices::UploadListing.new(listing_params)
          result = rea.upload_listing

          if result.success?
            # RealEstate.com.au returns a unique Listing ID
            # which we need to associate with the property
            # for future API interaction with this property
            property.update_column(:rea_listing_id, result.upload_id)
            property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_rea_listing', result: 'success', payload: result.response)
          else
            add_error_to_activity_log(property, result)
            result
          end
        end

        private

        def params(property)
          {
            payload: RealEstateAuServices::Property.create(property).new_listing_as_xml,
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
            action: 'uploaded_rea_listing',
            result: 'failure',
            payload: result.response,
            body: result.response
          )
        end
      end
    end
  end
end