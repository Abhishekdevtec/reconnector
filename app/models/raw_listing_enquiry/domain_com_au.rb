# frozen_string_literal: true

# Holds a raw listing enquiry for RealEstate.com.au and exposes the data
# view helper methods
class RawListingEnquiry::DomainComAu < RawListingEnquiry
  def property_portal
    :commercial_real_estate
  end

  def enquiry_id
    body['id']
  end

  def agency_id
    body['metaData']['agencyid']
  end

  def received_at
    body['dateReceived']
  end

  def processed_at
    nil
  end

  def enquiry_type
    body['enquiryType']
  end

  def message
    body['message']
  end

  def requested_information
    nil
  end

  def agent_recipients
    body['recipientsDeliveryStatus'].map { |recipient| recipient['recipient']['address'] }.uniq
  end

  def listing_id
    body['referenceId']
  end

  # The Reconnector > Property.internal_id
  def internal_id
    body['listing']['externalListingId']
  end

  def sender_first_name
    body['sender']['firstName']
  end

  def sender_last_name
    body['sender']['lastName']
  end

  def sender_email
    body['sender']['email']
  end

  def sender_phone
    body['sender']['phoneNumber']
  end

  def preferred_contact_method
    nil
  end

  def subject
    nil
  end

  def linked_agent
    account.agents.find_by(email: agent_recipients) || NilAgent.new
  end

  def linked_property
    # Try to find the property in the Domain listings first
    listing = account.domain_com_au_listings.find_by(listing_id: listing_id)
    return listing.property if listing.present? && listing.property.present?

    # If not found, try to find the property in the RealCommercial listings
    account.properties.find_by(domain_com_au_listing_id: listing_id)
  end

  def linked_contact
    account.contacts.find_by(first_name: sender_first_name, last_name: sender_last_name, email: sender_email)
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
