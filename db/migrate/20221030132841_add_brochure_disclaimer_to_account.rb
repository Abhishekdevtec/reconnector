class AddBrochureDisclaimerToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :brochure_disclaimer, :string, default: nil
  end
end
