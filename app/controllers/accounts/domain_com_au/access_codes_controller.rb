# frozen_string_literal: true

module Accounts
  module DomainComAu
    # According to https://developer.domain.com.au/docs/latest/authentication/oauth/authorization-code-grant:
    #
    # Once the user has authenticated, the user will be redirected back to the redirect_uri provided in Step 1 along with an authorisation code as part of the redirect url. The new redirect url will look like this
    # {redirect_uri}?code={code}&state={state}
    # redirect_uri: The redirect uri provided in Step 1. This is where your web application will do the exchange of authorisation code to obtain an access token.
    # code: the authorization code to be used next to get an access_token
    # state: the same state value as provided in Step 1
    class AccessCodesController < AuthentificationController
      # GET /accounts/:id/domain_com_au_access_codes/new
      def new
        update_authorization_code = AppServices::DomainComAu::UpdateAuthorizationCode.new.update_authorization_code(authorization_params)

        # TODO: Refactor this ... there has to be a more elegant way to do both operations at once
        get_access_token = AppServices::DomainComAu::GetAccessTokenFromAuthorizationCode.new(account_id: params[:id], redirect_uri: redirect_uri).get_access_token_from_authorization_code
        save_access_token(JSON.parse(get_access_token.body))

        if update_authorization_code.updated?
          redirect_to edit_account_path, notice: 'Authorization code saved.'
        else
          redirect_to edit_account_path, alert: 'Error obtaining an authorization code. Please try again later'
        end
      end

      private

      # Only pass expected params
      def authorization_params
        {
          account_id: params[:id],
          authorization_code: params[:code],
          state: params[:state],
          sessions_state: params[:session_state]
        }
      end

      def save_access_token(access_token_obj)
        @account.domain_com_au_access_token = access_token_obj['access_token']
        @account.domain_com_au_access_token_expires_at = access_token_obj['expires_in'].seconds.from_now
        @account.domain_com_au_access_token_type = access_token_obj['token_type']
        @account.domain_com_au_refresh_token = access_token_obj['refresh_token']
        @account.save(validate: false)
      end
    end
  end
end
