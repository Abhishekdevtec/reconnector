# == Schema Information
#
# Table name: prospects_properties_emails
#
#  agent_id         :bigint           not null
#  attach_brochures :boolean          default(FALSE)
#  contact_ids      :bigint           is an Array
#  created_at       :datetime
#  id               :bigint           not null, primary key
#  property_ids     :bigint           is an Array
#  sent_at          :datetime
#
# Indexes
#
#  index_prospects_properties_emails_on_agent_id  (agent_id)
#
require "test_helper"

class ProspectsPropertiesEmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
