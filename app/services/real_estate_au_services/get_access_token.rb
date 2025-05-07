# frozen_string_literal: true

# Class which is part of the
# Real Estate Au services
module RealEstateAuServices
  # Obtains an OAuth token from RealEstate.com.au
  # See https://partner.realestate.com.au/documentation/api/getting-started/
  class GetAccessToken
    # Pass in the credentials
    # client_id
    # client_secret
    def initialize(params = {})
      @client_id = params[:client_id]
      @client_secret = params[:client_secret]
    end

    def get_access_token
      response = HTTParty.post(endpoint, options)
      token    = JSON.parse(response.body)['access_token']

      if response.code.between?(200, 299)
        Result.new(success: true, access_token: token, response: response)
      else
        handle_error(response)
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

    def options
      {
        body: { grant_type: 'client_credentials' },
        basic_auth: authentification
      }
    end

    def authentification
      { username: @client_id, password: @client_secret }
    end

    def endpoint
      # Rails.application.credentials.rea[:access_token_endpoint]
      'https://api.realestate.com.au/oauth/token'
    end

    def handle_error(response)
      response_code = response&.code || nil
      Rails.logger.error("[RealEstateAuServices::GetAccessToken] ERROR getting access token. Got HTTP response #{response_code}")
      Rails.logger.error(response&.body)
      Result.new(success: false, response: response)
    end
  end
end
