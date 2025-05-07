# frozen_string_literal: true

module AppServices
  module DomainComAu
    # Class responsable for refreshing that access-token
    # which is then used for additional
    # Domain.com.au API calls.
    #
    # See https://developer.domain.com.au/docs/v1/authentication/oauth/refresh-tokens
    class RefreshAccessToken
      def initialize(params = {})
        @client  = DomainComAuServices::V1::Client.new
        @account = Account.find(params[:account_id])
      end

      def refresh_access_token
        result = @client.refresh_token(
          client_id: @account.domain_com_au_client_id,
          client_secret: @account.domain_com_au_client_secret,
          refresh_token: @account.domain_com_au_refresh_token
        )
        save_access_token_data(JSON.parse(result.body))
        Rails.logger.info "[#{self.class}] SUCCESS Updated authorization code."
        OpenStruct.new(refreshed?: true, response: result)
      rescue DomainComAuServices::V1::ApiExceptions::ApiExceptionError
        Rails.logger.error "[#{self.class}] ERROR refreshing the access token."
        OpenStruct.new(refreshed?: false, response: result)
      end

      private

      def save_access_token_data(obj)
        Rails.logger.info("[#{self.class}] obj: #{obj}")
        Rails.logger.info("Access data BEFORE update:")
        log_account_access_data
        @account.domain_com_au_access_token            = obj['access_token']
        @account.domain_com_au_refresh_token           = obj['refresh_token']
        @account.domain_com_au_access_token_type       = obj['token_type']
        @account.domain_com_au_access_token_expires_at = obj['expires_in'].seconds.from_now
        res = @account.save(validate: false)
        Rails.logger.info("@account.save returned #{res}")
        Rails.logger.info("Access data AFTER update:")
        log_account_access_data
      end

      def log_account_access_data
        Rails.logger.info("[#{self.class}] account domain.com.au info: Account #{@account.company_name}")
        Rails.logger.info("[#{self.class}] account domain.com.au info: domain_com_au_access_token #{@account.domain_com_au_access_token}")
        Rails.logger.info("[#{self.class}] account domain.com.au info: domain_com_au_refresh_token #{@account.domain_com_au_refresh_token}")
        Rails.logger.info("[#{self.class}] account domain.com.au info: domain_com_au_access_token_type #{@account.domain_com_au_access_token_type}")
        Rails.logger.info("[#{self.class}] account domain.com.au info: domain_com_au_access_token_expires_at #{@account.domain_com_au_access_token_expires_at}")
      end
    end
  end
end
