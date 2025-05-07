# frozen_string_literal: true

module ReaServices
  module V1
    module Apis
      module Listings
        # Upload a listing
        # https://partner.realestate.com.au/documentation/api/listings/usage/
        def create_listing(access_token, payload)
          endpoint = 'https://api.realestate.com.au/listing/v1/upload'
          options  = {
            headers: {
              'Authorization': "Bearer #{access_token}",
              'Content-Type': 'text/xml'
            },
            body: payload
          }
          HTTParty.post(endpoint, options)
        end

        # Get a listing
        # https://partner.realestate.com.au/documentation/api/listings/usage/#retrieve-a-listing-upload-report-by-uploadid
        def get_listing(access_token, upload_id)
          endpoint = "https://api.realestate.com.au/listing/v1/upload/#{upload_id}"
          options  = {
            headers: {
              'Authorization': "Bearer #{access_token}"
            }
          }
          HTTParty.get(endpoint, options)
        end

        # Delete a listing
        # https://partner.realestate.com.au/documentation/api/listings/usage/
        def destroy_listing(access_token, payload)
          endpoint = 'https://api.realestate.com.au/listing/v1/upload'
          options  = {
            headers: {
              'Authorization': "Bearer #{access_token}",
              'Content-Type': 'text/xml'
            },
            body: payload
          }
          HTTParty.post(endpoint, options)
        end
      end
    end
  end
end
