# frozen_string_literal: true

module AppServices
  module Rea
    # Destroy a Listing from RealEstate.com.au
    # See https://partner.realestate.com.au/documentation/api/listings/usage/#upload-a-listing
    class DestroyListing < ListingClient
      def destroy_listing
        Rails.logger.info "Destroying listing #{property.internal_id}..."
        Rails.logger.info payload.to_s
        response = rea_client.destroy_listing(access_token, payload)

        if response.success?
          upload_id = JSON.parse(response.body)['uploadId']
          property.update_column(:rea_listing_id, upload_id)
          property.update_column(:rea_listed, false)
          property.real_commercial_listing.delete if property.real_commercial_listing?
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'destroy_rea_listing', result: 'success', payload: response.body)
        else
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'destroy_rea_listing', result: 'failure', payload: response.body)
        end
      end

      private

      def payload
        RealEstateAuServices::Property.create(property).destroy_listing_as_xml
      end
    end
  end
end
