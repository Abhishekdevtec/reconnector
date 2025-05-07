# frozen_string_literal: true

module AppServices
  module DomainComAu
    # Class responsable for storing the authorization code
    # which is then used to get an access_token for additional
    # Domain.com.au API calls.
    #
    # See https://developer.domain.com.au/docs/latest/authentication/oauth/authorization-code-grant
    class UpdateAuthorizationCode
      def update_authorization_code(params = {})
        account = Account.find(params[:account_id])
        account.domain_com_au_authorization_code = params[:authorization_code]

        if account.save(validate: false)
          Rails.logger.debug "[#{self.class}] SUCCESS Updated authorization code."
          OpenStruct.new(updated?: true, authorization_code: params[:authorization_code])
        else
          handle_error(response)
        end
      rescue ActiveRecord::RecordNotFound
        handle_error(exception)
      end

      private

      def handle_error(response)
        Rails.logger.error("[#{self.class}] ERROR Updated authorization code.")
        Rails.logger.error(response&.body || response&.message)
        OpenStruct.new(updated?: false, response: response)
      end
    end
  end
end
