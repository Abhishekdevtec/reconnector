# frozen_string_literal: true

module Accounts
  # Job which finds all Accounts who use
  # Microsoft Graph in batches
  # and calls the refresh_access_tokens method
  # on each agent with a Microsoft Graph access token.

  # See https://learn.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow#refresh-the-access-token
  class RefreshMicrosoftGraphAccessTokensJob < ApplicationJob
    queue_as :default
    retry_on StandardError, wait: 5.minutes, attempts: 3

    def perform(*args)
      Rails.logger.info("[#{self.class}.perform] called with args: #{args}")
      Account.where(enable_microsoft_graph_support: true).find_each do |account|
        account.agents.each do |agent|
          agent.refresh_microsoft_graph_access_token if need_to_refresh_microsoft_graph_access_token?(agent)
        end
      end
    end

    private

    def need_to_refresh_microsoft_graph_access_token?(agent)
      agent.microsoft_graph_token? && agent.microsoft_graph_token.expired?
    end
  end
end
