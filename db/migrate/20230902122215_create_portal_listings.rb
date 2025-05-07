class CreatePortalListings < ActiveRecord::Migration[7.0]
  def change
    create_table :portal_listings do |t|
      t.belongs_to :property, null: false, foreign_key: true
      t.string :type
      t.string :listing_id
      t.string :upload_id, null: false

      t.timestamps
    end
  end
end
