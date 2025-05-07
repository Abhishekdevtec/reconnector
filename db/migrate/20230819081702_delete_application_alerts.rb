class DeleteApplicationAlerts < ActiveRecord::Migration[7.0]
  def change
    drop_table :application_alerts
  end
end
