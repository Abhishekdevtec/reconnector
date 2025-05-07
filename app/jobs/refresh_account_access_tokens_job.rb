# frozen_string_literal: true

# Job which finds all accounts in batches
# and calls the refresh_access_tokens method
# on each account.
class RefreshAccountAccessTokensJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info("[#{self.class}.perform] called with args: #{args}")
    DomainComAu::RefreshAccessTokensJob.perform_now
    Accounts::RefreshMicrosoftGraphAccessTokensJob.perform_now

    # Add additional API Refresh Token jobs here...
  end
end
