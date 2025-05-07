class AddDomainComAuWebhooksVerificationCodeToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :domain_com_au_webhooks_verification_code, :string, default: nil
  end
end
