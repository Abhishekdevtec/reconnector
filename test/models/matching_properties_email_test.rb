# == Schema Information
#
# Table name: matching_properties_emails
#
#  agent_id         :bigint           not null
#  attach_brochures :boolean          default(FALSE)
#  contact_id       :bigint           not null
#  created_at       :datetime
#  email_sent_at    :datetime
#  id               :bigint           not null, primary key
#  property_ids     :integer          is an Array
#
# Indexes
#
#  index_matching_properties_emails_on_agent_id    (agent_id)
#  index_matching_properties_emails_on_contact_id  (contact_id)
#
require "test_helper"

class MatchingPropertiesEmailTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:body)
  end
end
