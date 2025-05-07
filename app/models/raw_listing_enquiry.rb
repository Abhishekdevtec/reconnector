# frozen_string_literal: true

# Holds a raw listing enquiry from a property portal
# This class is meant to be overriden by child classes/models
# which then rich with methods to expose the data
# depending on the property portal.
class RawListingEnquiry < ApplicationRecord
  belongs_to :account

  validates :body, presence: true

  after_save_commit :create_listing_enquiry_later

  # Methods that need to be overriden by the child classes (STI)
  def property_portal
    raise NotImplementedError
  end

  def enquiry_id
    raise NotImplementedError
  end

  def agency_id
    raise NotImplementedError
  end

  def received_at
    raise NotImplementedError
  end

  def processed_at
    raise NotImplementedError
  end

  def enquiry_type
    raise NotImplementedError
  end

  def message
    raise NotImplementedError
  end

  def requested_information
    raise NotImplementedError
  end

  def agent_recipients
    raise NotImplementedError
  end

  def listing_id
    raise NotImplementedError
  end

  def sender_first_name
    raise NotImplementedError
  end

  def sender_last_name
    raise NotImplementedError
  end

  def sender_email
    raise NotImplementedError
  end

  def sender_phone
    raise NotImplementedError
  end

  def preferred_contact_method
    raise NotImplementedError
  end

  def subject
    raise NotImplementedError
  end

  def linked_property?
    linked_property.present?
  end

  def linked_contact?
    linked_contact.present?
  end

  def linked_agent?
    linked_agent.present?
  end

  def create_listing_enquiry_later
    CreateListingEnquiryJob.perform_later(self)
  end

  def create_listing_enquiry_now
    account.listing_enquiries.create! do |listing_enquiry|
      listing_enquiry.reference_id = listing_id
      listing_enquiry.property_id = linked_property.id if linked_property?
      listing_enquiry.property_portal = property_portal
      listing_enquiry.enquiry_id = enquiry_id
      listing_enquiry.reference_id = listing_id
      listing_enquiry.sender_first_name = sender_first_name
      listing_enquiry.sender_last_name = sender_last_name
      listing_enquiry.sender_email = sender_email
      listing_enquiry.sender_phone = sender_phone
      listing_enquiry.message = message
      listing_enquiry.enquired_at = received_at
      listing_enquiry.contact_id = linked_contact.id if linked_contact?
      listing_enquiry.agent_id = linked_agent.id if linked_agent?
    end
  end

  class CreateListingEnquiryJob < ApplicationJob
    queue_as :default

    def perform(raw_listing_enquiry)
      raw_listing_enquiry.create_listing_enquiry_now
    end
  end
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
