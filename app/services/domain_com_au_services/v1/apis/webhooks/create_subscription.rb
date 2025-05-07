# frozen_string_literal: true

module DomainComAuServices
  module V1
    module Apis
      module Webhooks
        module CreateSubscription
          # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/references/webhooks_createsubscription
          def create_subscription(webhook_id, owner_id, owner_type, resource_type)
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            endpoint = if Rails.env.production?
                         "v1/webhooks/#{webhook_id}/subscriptions"
                       else
                         "sandbox/v1/webhooks/#{webhook_id}/subscriptions"
                       end
            body = {
              'ownerId': owner_id,
              'ownerType': owner_type,
              'resourceType': resource_type
            }
            response = client.put(endpoint, body.to_json, headers)
            build_create_subscription_response(response)
          end

          private

          def build_create_subscription_response(response)
            OpenStruct.new(
              success?: response.status == 201,
              created?: response.status == 201,
              status: response.status,
              body: response.body
            )
          end
        end
      end
    end
  end
end
