# == Schema Information
#
# Table name: listing_enquiries
#
#  account_id        :bigint
#  agent_id          :bigint
#  contact_id        :bigint
#  created_at        :datetime         not null
#  enquired_at       :datetime
#  enquiry_id        :string
#  id                :bigint           not null, primary key
#  message           :text
#  property_id       :integer
#  property_portal   :string
#  reference_id      :string
#  sender_email      :string
#  sender_first_name :string
#  sender_last_name  :string
#  sender_phone      :string
#
# Indexes
#
#  index_listing_enquiries_on_account_id   (account_id)
#  index_listing_enquiries_on_agent_id     (agent_id)
#  index_listing_enquiries_on_contact_id   (contact_id)
#  index_listing_enquiries_on_property_id  (property_id)
#
require 'test_helper'

class ListingEnquiryTest < ActiveSupport::TestCase
  def setup
    @listing_enquiry = ListingEnquiry.new(
      account: accounts(:one),
      property_portal: 'example_portal',
      enquiry_id: '12345'
    )
  end

  test 'should be valid' do
    assert @listing_enquiry.valid?
  end

  test 'should be invalid without property_portal' do
    @listing_enquiry.property_portal = nil
    refute @listing_enquiry.valid?
    assert_includes @listing_enquiry.errors[:property_portal], "can't be blank"
  end

  test 'should be invalid without enquiry_id' do
    @listing_enquiry.enquiry_id = nil
    refute @listing_enquiry.valid?
    assert_includes @listing_enquiry.errors[:enquiry_id], "can't be blank"
  end

  test 'name method should return combined first and last name' do
    @listing_enquiry.sender_first_name = 'John'
    @listing_enquiry.sender_last_name = 'Doe'
    assert_equal 'John Doe', @listing_enquiry.sender_name
  end

  test 'name method should return "No name" if no first and last name' do
    @listing_enquiry.sender_first_name = nil
    @listing_enquiry.sender_last_name = nil
    assert_equal 'No name', @listing_enquiry.sender_name
  end
end
