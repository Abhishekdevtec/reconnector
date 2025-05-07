class ProspectsPropertiesEmail < ApplicationRecord
  include HasUniqueLocalDirectory
  belongs_to :agent

  has_rich_text     :body
  has_many_attached :files

  validates :agent, :body, presence: true
  validates :contact_ids, length: { minimum: 1, message: 'You must select at lease one contact' }
  validates :property_ids, length: { minimum: 1, message: 'You must select at lease one property' }
end

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
