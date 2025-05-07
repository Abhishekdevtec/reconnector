class ListingEnquiry < ApplicationRecord
  after_create_commit :create_contact, if: :can_create_contact?

  include Viewable

  belongs_to :account
  belongs_to :agent, optional: true
  belongs_to :contact, optional: true
  belongs_to :property, optional: true

  validates :property_portal, presence: true
  validates :enquiry_id, presence: true, uniqueness: { scope: %i[property_portal account_id] }

  def sender_name
    return 'No name' if sender_first_name.blank? && sender_last_name.blank?

    [sender_first_name, sender_last_name].compact_blank.join(' ')
  end

  def property?
    property_id.present? && Property.exists?(property_id)
  end

  def contact?
    contact_id.present? && Contact.exists?(contact_id)
  end

  def agent
    return NilAgent.new unless agent_id.present?

    Agent.find(agent_id)
  end

  private

  # Create a contact from the enquiry
  # with classifications based on the
  # property type
  def create_contact
    contact = agent.individuals.create!(
      first_name: sender_first_name,
      last_name: sender_last_name,
      email: sender_email,
      phone: sender_phone,
      account_id: account_id
    )
    add_classifications(contact)
    self.update_attribute(:contact_id, contact.id)
  end

  def add_classifications(contact)
    return unless property? && property.contract?

    ClassifierTag.create!(taggable: contact, classifier: prospective_tenant_classifier) if property.for_lease?
    ClassifierTag.create!(taggable: contact, classifier: prospective_buyer_classifier) if property.for_sale?
  end

  def prospective_buyer_classifier
    account.classifiers.find_by(name: 'Buyer')
  end

  def prospective_tenant_classifier
    account.classifiers.find_by(name: 'Prospective Tenant')
  end

  # We can create a contact if we have
  # an email address,
  # no contact_id,
  # and an agent_id
  def can_create_contact?
    contact_id.blank? && sender_email.present? && agent_id.present?
  end
end

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
