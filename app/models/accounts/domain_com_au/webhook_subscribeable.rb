# frozen_string_literal: true

module Accounts
  module DomainComAu
    # Account model concern which provides
    # CRUD functionality for Domain.com.au Webhook Subscriptions
    module WebhookSubscribeable
      include ActiveSupport::Concern

      def domain_com_au_webhook_subscriptions
        AppServices::DomainComAu::GetWebhookSubscriptions.new(self).get_webhook_subscriptions
      end
    end
  end
end
