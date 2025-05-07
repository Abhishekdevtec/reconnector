class RenameUniqueSpaceInProperties < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :unique_space, :unique_space_deprecated
  end
end
