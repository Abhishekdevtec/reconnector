# frozen_string_literal: true

# app/models/concerns/account_support_for_rea.rb

module AccountSupportForRea
  extend ActiveSupport::Concern

  # Add virtual attributes
  # so we can set and get
  # our rea_encrypted_client_secret
  def rea_client_secret=(value)
    self.rea_encrypted_client_secret = EncryptionService.encrypt(value)
  end

  def rea_client_secret
    EncryptionService.decrypt(self.rea_encrypted_client_secret)
  end

  # Account has realestate.com.au credentials
  def rea_credentials?
    self.rea_client_id.present? && self.rea_encrypted_client_secret.present?
  end
end
