# frozen_string_literal: true

module DomainComAu
  module DomainComAuRedirectHelper
    def authorization_code_grant_url(account)
      client_id    = account.domain_com_au_client_id
      redirect_uri = accounts_domain_com_au_access_codes_url(account.id)
      DomainComAuServices::V1::Client.new.authorization_code_grant_url(client_id: client_id, redirect_uri: redirect_uri)
    end
  end
end
