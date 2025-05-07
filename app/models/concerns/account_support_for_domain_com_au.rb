# frozen_string_literal: true

# app/models/concerns/account_support_for_domain_com_au.rb

module AccountSupportForDomainComAu
  extend ActiveSupport::Concern

  def need_to_update_refresh_token?
    self.domain_com_au_access_token_expires_at.present? && self.domain_com_au_access_token_expires_at.past?
  end

  # Refreshes the access token for the account.
  def refresh_domain_com_au_access_token
    # Only refresh the access token if we have credentials
    return unless domain_com_au_credentials?

    refresh_access_token_service = AppServices::DomainComAu::RefreshAccessToken.new({ account_id: self.id })
    refresh_access_token_service.refresh_access_token
  end

  # Add virtual attributes
  # so we can set and get
  # our domain_com_au_encrypted_client_secret
  def domain_com_au_client_secret=(value)
    self.domain_com_au_encrypted_client_secret = EncryptionService.encrypt(value)
  end

  def domain_com_au_client_secret
    EncryptionService.decrypt(self.domain_com_au_encrypted_client_secret)
  end

  # Does the Account have domain.com.au credentials
  def domain_com_au_credentials?
    self.domain_com_au_client_id.present? && self.domain_com_au_encrypted_client_secret.present?
  end

  def domain_com_au_authorization_code=(value)
    self.domain_com_au_encrypted_authorization_code = EncryptionService.encrypt(value)
  end

  def domain_com_au_authorization_code
    EncryptionService.decrypt(self.domain_com_au_encrypted_authorization_code)
  end

  def authorization_code?
    self.domain_com_au_encrypted_authorization_code.present?
  end

  def domain_com_au_access_token=(value)
    self.domain_com_au_encrypted_access_token = EncryptionService.encrypt(value)
  end

  def domain_com_au_access_token
    EncryptionService.decrypt(self.domain_com_au_encrypted_access_token)
  end

  def domain_com_au_access_token?
    self.domain_com_au_encrypted_access_token.present?
  end

  def domain_com_au_refresh_token=(value)
    self.domain_com_au_encrypted_refresh_token = EncryptionService.encrypt(value)
  end

  def domain_com_au_refresh_token
    EncryptionService.decrypt(self.domain_com_au_encrypted_refresh_token)
  end

  def domain_com_au_refresh_token?
    self.domain_com_au_encrypted_refresh_token.present?
  end
end
