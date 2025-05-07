# frozen_string_literal: true

module AccountSupportForMicrosoftGraph
  extend ActiveSupport::Concern

  # Add virtual attributes
  # so we can set and get
  # our azure_encrypted_client_secret
  def azure_client_secret=(value)
    self.azure_encrypted_client_secret = EncryptionService.encrypt(value)
  end

  def azure_client_secret
    EncryptionService.decrypt(self.azure_encrypted_client_secret)
  end

  def sends_email_via_microsoft_graph?
    enable_microsoft_graph_support && azure_application_id.present? && azure_tenant_id.present? && azure_encrypted_client_secret.present?
  end
end
