class AddCurrentLocationSettingsToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :current_country, :string, default: nil, comment: 'Holds the last used country for the agent'
    add_column :agents, :current_state,   :string, default: nil, comment: 'Holds the last used state for the agent'
  end
end
