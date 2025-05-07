# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Get all the webhook subscriptions from Domain.com.au using
    # their API
    #
    # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/references/webhooks_listsubscriptions
    class GetWebhookSubscriptions
      def initialize(account)
        @account = account
      end

      def get_webhook_subscriptions
        access_token = @account.domain_com_au_access_token
        webhook_id   = @account.domain_com_au_webhooks_id
        client       = DomainComAuServices::V1::Client.new(access_token)
        response     = client.get_subscriptions(webhook_id)

        if response.code.between?(200, 299)
          OpenStruct.new(success?: true, subscriptions: build_subscriptions(JSON.parse(response.body)))
        else
          handle_error(response)
        end
      rescue DomainComAuServices::V1::ApiExceptions::ApiExceptionError => e
        handle_exception(e)
      end

      private

      def build_subscriptions(json)
        subscriptions = []
        json.each do |subscription|
          subscriptions << OpenStruct.new(subscription.transform_keys(&:underscore))
        end
        subscriptions
      end

      def handle_error(response)
        response_code = response&.code || nil
        Rails.logger.error("[#{self.class}] ERROR getting a list of the webhook subscriptions. Got HTTP response #{response_code}")
        Rails.logger.error(response&.body)
        OpenStruct.new(success?: false, subscriptions: nil, error: response.body)
      end

      def handle_exception(e)
        Rails.logger.error("[#{self.class}] ERROR getting a list of the webhook subscriptions. Got EXCEPTION response #{e}")
        Rails.logger.error(e.message)
        OpenStruct.new(success?: false, subscriptions: nil, error: e.message)
      end
    end
  end
end
