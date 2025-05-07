# frozen_string_literal: true

# Low-level client class which is part of the
# Domain.com API services
#
# See https://developer.domain.com.au/docs/v1/getting-started
module ReaServices
  module V1
    # Structure based on an super article
    # https://www.nopio.com/blog/how-to-create-an-api-wrapper-of-an-external-service-in-rails/
    class Client
      include Apis::Listings
      include Apis::Leads

      def get_access_token(client_id, client_secret)
        endpoint = 'https://api.realestate.com.au/oauth/token'
        options  = {
          body: { grant_type: 'client_credentials' },
          basic_auth: { username: client_id, password: client_secret }
        }
        HTTParty.post(endpoint, options)
      end
    end
  end
end
