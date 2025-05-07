# frozen_string_literal: true

module DomainComAuServices
  module V1
    module Apis
      module Webhooks
        module DeleteSubscription
          # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/references/webhooks_deletesubscription
          def delete_subscription(subscription_id)
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            endpoint = if Rails.env.production?
                         "v1/subscriptions/#{subscription_id}"
                       else
                         "sandbox/v1/subscriptions/#{subscription_id}"
                       end
            response = client.delete(endpoint, headers)
            build_delete_subscription_response(response)
          end

          private

          def build_delete_subscription_response(response)
            OpenStruct.new(
              success?: response.status == 204,
              deleted?: response.status == 204,
              status: response.status,
              body: response.body
            )
          end
        end
      end
    end
  end
end
