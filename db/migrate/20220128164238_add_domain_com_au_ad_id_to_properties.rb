class AddDomainComAuAdIdToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :domain_com_au_listing_id, :string, default: nil
  end
end
