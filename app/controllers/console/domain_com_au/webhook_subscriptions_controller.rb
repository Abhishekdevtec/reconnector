# frozen_string_literal: true

module Console
  module DomainComAu
    # Controller which is just a front-end for the Domain.com.au Webhook Subscriptions API
    # See https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/
    class WebhookSubscriptionsController < ConsoleController
      def index
        @webhook_subscriptions = @account.domain_com_au_webhook_subscriptions
      end

      def new
      end

      def create
        webhook_id    = create_subscription_params[:subscriber_id]
        owner_id      = create_subscription_params[:owner_id]
        owner_type    = create_subscription_params[:owner_type]
        resource_type = create_subscription_params[:resource_type]
        response = client.create_subscription(webhook_id, owner_id, owner_type, resource_type)
        if response.success?
          head :ok
        else
          head :unprocessable_entity, notice: response.body
        end
      end

      def show
      end

      def destroy
      end

      private

      def create_subscription_params
        params
          .require(:domain_com_au_webhook_subscription)
          .permit(:subscriber_id, :owner_id, :owner_type, :resource_type)
      end

      def client
        ::DomainComAuServices::V1::Client.new(@account.domain_com_au_access_token)
      end
    end
  end
end
