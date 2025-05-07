# frozen_string_literal: true

module Accounts
  module DomainComAu
    class AuthentificationController < ApplicationController
      before_action :authenticate_agent!

      private

      def redirect_uri
        accounts_domain_com_au_access_codes_url(@account.id)
      end
    end
  end
end
