class CreateIntegrationsRealestateComAuLeadsApis < ActiveRecord::Migration[7.0]
  def change
    create_table :integrations_realestate_com_au_leads_apis do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.boolean    :enabled
      t.datetime   :last_requested_at
      t.string     :last_request_status

      t.timestamps
    end
  end
end
