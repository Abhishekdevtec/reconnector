# frozen_string_literal: true

# Low-level client class which implements the
# GriffinProperty.com.au API services
module GriffinPropertyComAu
  module Apim
    module V1
      class Client
        API_ENDPOINT = 'https://griffinproperty.com.au/apim/v1/listings'
        HTTP_OK_CODE = 200

        ApiResponse = Struct.new(:success?, :http_status, :http_body)

        attr_reader :api_token

        def initialize(api_token = nil)
          @api_token = api_token
        end

        def get_listing(listing_id)
          headers  = { 'Authorization': "Bearer #{@api_token}" }
          endpoint = "#{API_ENDPOINT}/#{listing_id}"
          response = client.get(endpoint, headers)
          build_response(response)
        end

        def post_listing(payload = {})
          body     = payload
          headers  = { 'Authorization': "Bearer #{@api_token}", 'Content-Type': 'application/json' }
          response = client.post(API_ENDPOINT, body, headers)
          build_response(response)
        end

        private

        def client
          @client ||= Faraday.new(API_ENDPOINT) do |client|
            client.request :url_encoded
            client.adapter Faraday.default_adapter
            client.headers['Authorization'] = "Bearer #{@api_token}" if @api_token.present?
            client.response :logger, Rails.logger, bodies: { request: true, response: true }
          end
        end

        def build_response(response)
          ApiResponse.new(response_successful?(response), response.status, response.body)
        end

        def response_successful?(response)
          response.status == HTTP_OK_CODE
        end
      end
    end
  end
end
