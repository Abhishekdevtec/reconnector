module Accounts
  module DomainComAu
    class AccessTokensController < AuthentificationController
      # GET /account/domain_com_au_access_token/new
      def new
        @client = DomainComAuServices::V1::Client.new
        redirect_to(
          @client.authorization_code_grant_url(client_id: @account.domain_com_au_client_id, redirect_uri: redirect_uri),
          allow_other_host: true
        )
      end
    end
  end
end
