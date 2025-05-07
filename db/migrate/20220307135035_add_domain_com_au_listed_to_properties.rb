class AddDomainComAuListedToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :domain_com_au_listed, :boolean, default: false
  end
end
