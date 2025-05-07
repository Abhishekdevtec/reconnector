class AddFaxToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :fax, :string, default: nil
  end
end
