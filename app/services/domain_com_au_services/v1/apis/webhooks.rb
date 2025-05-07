# frozen_string_literal: true

module DomainComAuServices
  module V1
    module Apis
      # Functions used to manage webhooks over at
      # Domain.com.au
      # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks
      module Webhooks
        include Webhooks::CreateSubscription
        include Webhooks::DeleteSubscription

        # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/references/webhooks_listsubscriptions
        def get_subscriptions(webhook_id)
          headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
          endpoint = if Rails.env.production?
                       "v1/webhooks/#{webhook_id}/subscriptions/"
                     else
                       "sandbox/v1/webhooks/#{webhook_id}/subscriptions/"
                     end
          request(http_method: :get, endpoint: endpoint, headers: headers)
        end

        # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/references/webhooks_getsubscription
        def get_subscription(subscription_id)
          headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
          endpoint = if Rails.env.production?
                       "v1/subscriptions/#{subscription_id}"
                     else
                       "sandbox/v1/subscriptions/#{subscription_id}"
                     end
          request(http_method: :get, endpoint: endpoint, headers: headers)
        end
      end
    end
  end
end
