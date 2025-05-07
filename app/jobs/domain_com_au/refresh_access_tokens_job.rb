# frozen_string_literal: true

# Job which finds all accounts in batches
# and calls the refresh_access_tokens method
# on each account.

# See https://developer.domain.com.au/docs/v1/authentication/oauth/refresh-tokens
#
# Using Refresh Tokens
# Refresh tokens are only available for the
# Authorization Code grant type. Refresh tokens
# are used in scenarios where offline access (on a user's behalf)
# is required by your application without the need to go through
# the entire process of Authorization Code flow every time
# an access token expires.
module DomainComAu
  class RefreshAccessTokensJob < ApplicationJob
    queue_as :default
    retry_on StandardError, wait: 5.minutes, attempts: 3

    def perform(*args)
      Rails.logger.info("[#{self.class}.perform] called with args: #{args}")
      Account.find_each do |account|
        Thread.new do
          account.refresh_domain_com_au_access_token if account.need_to_update_refresh_token?
        end
      end
    end
  end
end
