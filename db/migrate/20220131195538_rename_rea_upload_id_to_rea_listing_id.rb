class RenameReaUploadIdToReaListingId < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :rea_upload_id, :rea_listing_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
