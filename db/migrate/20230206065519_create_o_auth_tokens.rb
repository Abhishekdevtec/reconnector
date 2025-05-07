class CreateOAuthTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :o_auth_tokens do |t|
      t.bigint   :tokenable_id
      t.string   :tokenable_type
      t.string   :access_token, null: false
      t.datetime :expires_at, null: false
      t.string   :provider, null: false, comment: 'The name of the OAuth token service (Microsoft Graph, Twitter, Google, etc.)'
      t.string   :refresh_token, null: false

      t.timestamps
    end
    add_index :o_auth_tokens, :tokenable_id
    add_index :o_auth_tokens, :tokenable_type
  end
end
