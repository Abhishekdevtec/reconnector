class AddArchivedAtToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :archived_at, :datetime, default: nil
  end
end
