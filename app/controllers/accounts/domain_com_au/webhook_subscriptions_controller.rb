# frozen_string_literal: true

module Accounts
  module DomainComAu
    class WebhookSubscriptionsController < AuthentificationController
      # DELETE /accounts/:account_id/domain_com_au/webhook_subscriptions/:id(.:format)
      def destroy
        account = Account.find(params[:account_id])
        subscription_id = params[:id]
        response = AppServices::DomainComAu::DeleteWebhookSubscriptions.new(account, subscription_id).delete_webhook_subscription

        if response.success?
          redirect_to edit_account_listings_path, status: :see_other, notice: 'Webhook subscription deleted.'
        else
          redirect_to edit_account_listings_path, status: :see_other, alert: 'Error deleting the webhook subscription. Please try again later'
        end
      end
    end
  end
end
