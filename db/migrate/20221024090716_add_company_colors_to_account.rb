class AddCompanyColorsToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :primary_color, :string
    add_column :accounts, :secondary_color, :string
  end
end
