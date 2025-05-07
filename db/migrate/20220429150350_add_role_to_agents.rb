class AddRoleToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :role, :integer, default: 0
  end
end
