class AddAccountToInboundWebhooks < ActiveRecord::Migration[7.0]
  def change
    add_reference :inbound_webhooks, :account, null: false, foreign_key: true
  end
end
