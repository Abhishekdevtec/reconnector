class RenameSuiteColumnInProperties < ActiveRecord::Migration[7.0]
  def change
    rename_column :properties, :suite, :unit_suite_shop

    # Migrate data from the unique_space_deprecated column to the unit_suite_shop column
    Property.unscoped.where(unit_suite_shop: nil).each do |property|
      property.update!(unit_suite_shop: property.unique_space_deprecated) unless property.unique_space_deprecated.blank?
    end
  end
end
