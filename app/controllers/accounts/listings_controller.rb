# frozen_string_literal: true

module Accounts
  class ListingsController < ApplicationController
    before_action :authenticate_agent!
    before_action :verify_account_manager!
    before_action :set_selected_account_menu_option

    def edit
      webhook_subscription_service = AppServices::DomainComAu::GetWebhookSubscriptions.new(@account).get_webhook_subscriptions
      @domain_com_au_webhook_subscriptions = webhook_subscription_service.subscriptions
      @account.realestate_com_au_leads_api ||= @account.build_realestate_com_au_leads_api
    end

    private

    def set_selected_account_menu_option
      @selected_account_menu_option = :listings
    end
  end
end
