class MatchingPropertiesEmail < ApplicationRecord
  include HasUniqueLocalDirectory
  belongs_to :agent
  belongs_to :contact

  has_rich_text     :body
  has_many_attached :files

  validates :agent, :contact, :body, presence: true
  validates :property_ids, length: { minimum: 1, message: 'You must select at lease one property' }
end

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
