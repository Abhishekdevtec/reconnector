class Contact < ApplicationRecord
  
  include Taggable
  include HasAddresses
  include HasPhysicalAddress
  include HasPostalAddress
  include Shareable
  include UnsharedByDefault
  include ::PgSearch::Model
  include NormalizeBlankValues
  include MicrosoftGraphSynchronizable
  include ContactSupportForMicrosoftGraph
  include Viewable

  belongs_to :agent
  belongs_to :account
  has_many :classifications,              as: :classifiable, dependent: :destroy
  has_many :property_contacts,            dependent: :destroy # Should we really destroy this link?
  has_many :property_requirements,        dependent: :destroy
  has_many :prospect_notification_emails, dependent: :destroy
  has_many :matching_properties_emails,   dependent: :destroy
  has_many :listing_enquiries,            dependent: :nullify

  validates :type, presence: true
  validates :account_id, accounts_are_coherent: true

  pg_search_scope :search, against: %i[first_name last_name business_name email phone mobile], using: {
    tsearch: {
      any_word: false
    },
    trigram: {
      threshold: 0.1,
      only: %i[first_name last_name business_name email]
    }
  }

  has_rich_text :notes

  scope :created_by, ->(agent) { where(agent_id: agent.id) }
  scope :visible_by, ->(agent) { where(account_id: agent.account.id, share: true).or(Contact.where(agent_id: agent.id)) }
  scope :recent, -> { order(created_at: :desc).limit(5) }

  def individual?
    self.class.to_s.downcase == 'individual'
  end

  def business?
    self.class.to_s.downcase == 'business'
  end

  def classification_names
    classifier_tags.map(&:name)
  end
end

# == Schema Information
#
# Table name: contacts
#
#  account_id                     :bigint           not null
#  agent_id                       :bigint           not null
#  business_id                    :bigint
#  business_name                  :string
#  classifiable_id                :bigint
#  classifiable_type              :string
#  created_at                     :datetime         not null
#  email                          :string
#  ews_change_key                 :string
#  ews_created_at                 :datetime
#  ews_imported_from_ews          :boolean          default(FALSE)
#  ews_item_id                    :string
#  ews_last_modified_at           :datetime
#  ews_received_at                :datetime
#  ews_sent_at                    :datetime
#  fax                            :string
#  first_name                     :string
#  id                             :bigint           not null, primary key
#  job_title                      :string
#  last_name                      :string
#  legal_name                     :string
#  mobile                         :string
#  notes                          :text
#  phone                          :string
#  registration                   :string
#  share                          :boolean          default(FALSE)
#  source_id                      :string
#  synchronize_with_office_online :boolean          default(FALSE)
#  type                           :string
#  updated_at                     :datetime         not null
#  url                            :string
#
# Indexes
#
#  index_contacts_on_account_id    (account_id)
#  index_contacts_on_agent_id      (agent_id)
#  index_contacts_on_business_id   (business_id)
#  index_contacts_on_classifiable  (classifiable_type,classifiable_id)
#
