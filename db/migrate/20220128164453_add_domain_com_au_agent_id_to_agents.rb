class AddDomainComAuAgentIdToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :domain_com_au_agent_id, :string, default: nil
  end
end
