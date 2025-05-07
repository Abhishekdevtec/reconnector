# frozen_string_literal: true

# Class which uploads a property to
# GriffinProperty.com.au
require 'zip'

module AppServices
  module GriffinPropertyComAu
    class CreateListing
      def initialize(property_id)
        @property_id = property_id
        @account = property.account
      end

      def create_listing
        client  = ::GriffinPropertyComAu::Apim::V1::Client.new(property.account.griffin_property_com_au_api_token)
        payload = ::GriffinPropertyComAu::Apim::V1::Listing.new(@property_id).to_json
        Rails.logger.info payload.inspect

        response = client.post_listing(payload)

        if response.success?
          # Store the URL
          body = JSON.parse(response.http_body)
          property.update_column(:website_url, body['url'])
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_griffinproperty_com_au_listing', result: 'success', payload: response.http_body)
        else
          property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_griffinproperty_com_au_listing', result: 'failure', payload: response.http_body)
        end
        response
      end

      private

      def property
        @property ||= Property.find(@property_id)
      end
    end
  end
end
