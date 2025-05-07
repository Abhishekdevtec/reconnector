# frozen_string_literal: true

module AppServices
  module DomainComAu
    # Class responsable for getting an access token
    # from an authorization code.
    #
    # See https://developer.domain.com.au/docs/latest/authentication/oauth/authorization-code-grant
    class GetAccessTokenFromAuthorizationCode
      def initialize(account_id:, redirect_uri:)
        @client       = DomainComAuServices::V1::Client.new
        @account_id   = account_id
        @redirect_uri = redirect_uri
      end

      def get_access_token_from_authorization_code
        result = @client.exchange_authorization_code_for_access_token(
          client_id: account.domain_com_au_client_id,
          client_secret: account.domain_com_au_client_secret,
          authorization_code: account.domain_com_au_authorization_code,
          redirect_uri: @redirect_uri
        )
        result
      end

      private

      def account
        @account ||= Account.find(@account_id)
      end
    end
  end
end
