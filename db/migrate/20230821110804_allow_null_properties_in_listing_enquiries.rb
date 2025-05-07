class AllowNullPropertiesInListingEnquiries < ActiveRecord::Migration[7.0]
  def change
    change_column :listing_enquiries, :property_id, :integer, null: true
  end
end
