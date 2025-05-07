# frozen_string_literal: true

# Class which is part of the
# Domain.com API services
module AppServices
  module DomainComAu
    # Get all the webhook subscriptions from Domain.com.au using
    # their API
    #
    # See https://developer.domain.com.au/docs/latest/apis/pkg_webhooks/references/webhooks_deletesubscription
    class DeleteWebhookSubscriptions
      def initialize(account, subscription_id)
        @account = account
        @subscription_id = subscription_id
      end

      def delete_webhook_subscription
        access_token = @account.domain_com_au_access_token
        client       = DomainComAuServices::V1::Client.new(access_token)
        response     = client.delete_subscription(@subscription_id)

        if response.success?
          OpenStruct.new(success?: true, deleted?: true)
        else
          handle_error(response)
        end
      rescue DomainComAuServices::V1::ApiExceptions::ApiExceptionError => e
        handle_exception(e)
      end

      private

      def handle_error(response)
        Rails.logger.error("[#{self.class}] ERROR deleting the webhook subscription #{@subscription_id}. Got HTTP response #{response.status}")
        Rails.logger.error(response&.body)
        OpenStruct.new(success?: false, deleted?: false, error: response.body)
      end

      def handle_exception(e)
        Rails.logger.error("[#{self.class}] ERROR getting a list of the webhook subscriptions. Got EXCEPTION response #{e}")
        Rails.logger.error(e.message)
        OpenStruct.new(success?: false, deleted?: false, error: e.message)
      end
    end
  end
end
