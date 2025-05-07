class CreateRawListingEnquiries < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_listing_enquiries do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.string :type
      t.jsonb :body

      t.timestamps
    end
  end
end
