# frozen_string_literal: true

module AppServices
  module Rea
    # Class to upload a Listing to RealEstate.com.au
    # See https://partner.realestate.com.au/documentation/api/listings/usage/#upload-a-listing
    class CreateListing < ListingClient
      def create_listing
        response = rea_client.create_listing(access_token, payload)

        if response.success?
          # RealEstate.com.au returns a unique UploadId
          # which we need to associate with the property
          # so we can track the prcessing of the listing.
          upload_id = JSON.parse(response.body)['uploadId']

          # TODO: Remove this once we have a webhook ----
          property.update_column(:rea_listing_id, upload_id)
          property.update_column(:rea_listed, true)
          # ---------------------------------------------

          property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_rea_listing', result: 'success', payload: response.body)
          property.create_real_commercial_listing(upload_id: upload_id)
        else
          add_error_to_activity_log(property, response)
          response
        end
      end

      private

      def property
        @property ||= Property.find(@property_id)
      end

      def account
        @account ||= property.account
      end

      def payload
        RealEstateAuServices::Property.create(property).new_listing_as_xml
      end

      def client_id
        account.rea_client_id
      end

      def client_secret
        account.rea_client_secret
      end

      def add_error_to_activity_log(property, result)
        property.activity_logs.create(
          account: property.account,
          agent: property.agent,
          action: 'uploaded_rea_listing',
          result: 'failure',
          payload: result.response,
          body: result.body
        )
      end
    end
  end
end
