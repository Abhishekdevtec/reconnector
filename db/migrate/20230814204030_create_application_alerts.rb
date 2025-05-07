class CreateApplicationAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :application_alerts do |t|
      t.string :klass,        default: nil
      t.text :exception,      default: nil
      t.jsonb :params,        default: nil
      t.jsonb :response,      default: nil
      t.string :message,      default: nil
      t.datetime :created_at, nil: false
    end
  end
end
