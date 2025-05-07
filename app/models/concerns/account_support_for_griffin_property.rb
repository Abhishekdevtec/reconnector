# frozen_string_literal: true

# app/models/concerns/account_support_for_griffin_property.rb

# Helper methods to support Griffin Property FTP uploads
module AccountSupportForGriffinProperty
  extend ActiveSupport::Concern

  # Add virtual attributes
  # so we can set and get
  # secrets from the database
  def griffin_property_password=(value)
    self.griffin_property_encrypted_password = EncryptionService.encrypt(value)
  end

  def griffin_property_password
    EncryptionService.decrypt(self.griffin_property_encrypted_password)
  end

  def griffin_property_com_au_api_token=(value)
    self.encrypted_griffin_property_com_au_api_token = EncryptionService.encrypt(value)
  end

  def griffin_property_com_au_api_token
    EncryptionService.decrypt(self.encrypted_griffin_property_com_au_api_token)
  end

  # Account has realestate.com.au credentials
  def griffin_property_credentials?
    self.griffin_property_host_url.present? &&
      self.griffin_property_username.present? &&
      self.griffin_property_encrypted_password.present?
  end
end
