# == Schema Information
#
# Table name: prospect_notification_emails
#
#  contact_id  :bigint           not null
#  emailed_at  :datetime
#  id          :bigint           not null, primary key
#  property_id :bigint           not null
#
# Indexes
#
#  index_prospect_notification_emails_on_contact_id   (contact_id)
#  index_prospect_notification_emails_on_property_id  (property_id)
#
require "test_helper"

class ProspectNotificationEmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
