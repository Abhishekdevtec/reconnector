require "test_helper"

class RawListingEnquiryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: raw_listing_enquiries
#
#  account_id :bigint           not null
#  body       :jsonb
#  created_at :datetime         not null
#  id         :bigint           not null, primary key
#  type       :string
#  updated_at :datetime         not null
#
# Indexes
#
#  index_raw_listing_enquiries_on_account_id  (account_id)
#
