class AddReaUploadIdToProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :rea_upload_id, :string, default: nil
  end
end
