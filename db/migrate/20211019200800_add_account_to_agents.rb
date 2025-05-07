class AddAccountToAgents < ActiveRecord::Migration[6.1]
  def change
    add_reference :agents, :account, null: false, foreign_key: true
  end
end
