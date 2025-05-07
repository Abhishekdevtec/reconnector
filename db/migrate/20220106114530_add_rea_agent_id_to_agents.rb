class AddReaAgentIdToAgents < ActiveRecord::Migration[6.1]
  def change
    add_column :agents, :rea_agent_id, :string, default: nil
  end
end
