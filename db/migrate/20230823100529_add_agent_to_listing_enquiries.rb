class AddAgentToListingEnquiries < ActiveRecord::Migration[7.0]
  def change
    add_reference :listing_enquiries, :agent, foreign_key: true, null: true
  end
end
