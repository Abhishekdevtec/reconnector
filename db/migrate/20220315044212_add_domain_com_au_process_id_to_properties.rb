class AddDomainComAuProcessIdToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :domain_com_au_process_id, :string, default: nil
  end
end
