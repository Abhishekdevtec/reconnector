class AddContactToListingEnquiries < ActiveRecord::Migration[7.0]
  def change
    add_reference :listing_enquiries, :contact, foreign_key: true, null: true
  end
end
