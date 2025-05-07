class CreateListingEnquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :listing_enquiries do |t|
      t.references :property, null: false, foreign_key: true
      t.string :property_portal, default: nil, comment: 'The property portal that the enquiry came from. E.g. domain_com_au, realestate_com_au, etc.'
      t.string :enquiry_id, default: nil, comment: 'The ID of the enquiry in the property portal. This is an external ID which can be used to look up the enquiry in the property portal.'
      t.string :reference_id, default: nil, comment: 'The ID of the listing in the property portal. This is an external ID which can be used to look up the listing in the property portal.'
      t.string :sender_first_name, default: nil
      t.string :sender_last_name, default: nil
      t.string :sender_email, default: nil
      t.string :sender_phone, default: nil
      t.text :message, default: nil
      t.datetime :enquired_at, default: nil
      t.datetime :created_at, null: false
    end
  end
end
