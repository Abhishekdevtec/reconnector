# frozen_string_literal: true

module Microsoft
  module Graph
    module V1
      module Apis
        # Module to manage Graph Me calls
        # which returns a User object.
        module Me
          # See https://learn.microsoft.com/en-us/graph/api/user-get?view=graph-rest-1.0&tabs=http
          def me
            endpoint = 'me'
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            response = client.get(endpoint, headers)
            body     = JSON.parse(response.body, symbolize_names: true)
            OpenStruct.new(success?: response.status == 200, status: response.status, body: body, user: Microsoft::Graph::V1::Models::User.new(body))
          end
        end
      end
    end
  end
end
