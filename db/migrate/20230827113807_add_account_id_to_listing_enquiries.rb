class AddAccountIdToListingEnquiries < ActiveRecord::Migration[7.0]
  def change
    add_reference :listing_enquiries, :account, foreign_key: true

    ListingEnquiry.update_all(account_id: Account.where(company_name: 'Griffin Property').pluck(:id).first)
  end
end
