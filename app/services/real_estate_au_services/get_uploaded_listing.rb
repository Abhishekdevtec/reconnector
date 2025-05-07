# frozen_string_literal: true

# Class which is part of the
# Real Estate Au services
module RealEstateAuServices
  # Retrieve a Listing Upload Report by uploadID
  # from RealEstate.com.au
  # See https://partner.realestate.com.au/documentation/api/listings/usage/#retrieve-a-listing-upload-report-by-uploadid
  class GetUploadedListing
    # Pass in the credentials
    # client_id
    # client_secret
    def initialize(params = {})
      @upload_id     = params[:upload_id]
      @client_id     = params[:client_id]
      @client_secret = params[:client_secret]
    end

    def get_uploaded_listing
      response = HTTParty.post(endpoint, options)
      token    = JSON.parse(response.body)['access_token']

      if response.code.between?(200, 299)
        Result.new(success: true, access_token: token, response: response)
      else
        Result.new(success: false, response: response)
      end
    end

    # Rich helper class which returns
    # the result, access token and HTTP
    # response.
    class Result
      attr_reader :access_token

      def initialize(success:, access_token: nil, response: nil)
        @success = success
        @access_token = access_token
        @response = response
      end

      def success?
        @success
      end
    end

    private

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
      "https://api.realestate.com.au/listing/v1/upload/#{@upload_id}"
    end
  end
end
