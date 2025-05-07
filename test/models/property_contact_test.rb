# == Schema Information
#
# Table name: property_contacts
#
#  contact_id  :bigint           not null
#  created_at  :datetime         not null
#  id          :bigint           not null, primary key
#  property_id :bigint           not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_property_contacts_on_contact_id   (contact_id)
#  index_property_contacts_on_property_id  (property_id)
#
require "test_helper"

class PropertyContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
