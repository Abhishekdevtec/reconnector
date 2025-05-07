# frozen_string_literal: true

# Class which is part of the
# Real Estate Au services
module RealEstateAuServices
  # Upload a Listing Upload to from RealEstate.com.au
  # See https://partner.realestate.com.au/documentation/api/listings/usage/#upload-a-listing
  class UploadListing
    # Pass in the credentials
    # client_id
    # client_secret
    def initialize(params = {})
      @payload       = params[:payload]
      @client_id     = params[:client_id]
      @client_secret = params[:client_secret]
    end

    def upload_listing
      response  = HTTParty.post(endpoint, options)
      upload_id = JSON.parse(response.body)['uploadId']

      if response.code.between?(200, 299)
        Rails.logger.info("[RealEstateAuServices::UploadListing] SUCCESS Uploaded listing. Got HTTP response #{response.code}")
        Rails.logger.info(response&.body)
        property.update_column(:rea_listed, false)
        Result.new(success: true, upload_id: upload_id, response: response)
      else
        handle_error(response)
      end
    end

    # Rich helper class which returns
    # the result, access token and HTTP
    # response.
    class Result
      attr_reader :success, :upload_id, :response

      def initialize(success:, upload_id: nil, response: nil)
        @success   = success
        @upload_id = upload_id
        @response  = response
      end

      def success?
        @success
      end
    end

    private

    def options
      {
        headers: {
          'Authorization': "Bearer #{access_token}",
          'Content-Type': 'text/xml'
        },
        body: @payload
      }
    end

    def access_token
      response = RealEstateAuServices::GetAccessToken.new(credentials).get_access_token
      return nil unless response.success?

      response.access_token
    end

    def credentials
      {
        client_id: @client_id,
        client_secret: @client_secret
      }
    end

    def endpoint
      # Rails.application.credentials.config[:rea_partner_platform_endpoint]
      'https://api.realestate.com.au/listing/v1/upload'
    end

    def handle_error(response)
      response_code = response&.code || nil
      Rails.logger.error("[RealEstateAuServices::UploadListing] ERROR uploading listing. Got HTTP response #{response_code}")
      Rails.logger.error(response&.body)
      Result.new(success: false, response: response)
    end
  end
end
