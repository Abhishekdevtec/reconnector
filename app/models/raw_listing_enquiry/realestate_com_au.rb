# frozen_string_literal: true

# Holds a raw listing enquiry for RealEstate.com.au and exposes the data
# view helper methods
# See https://partner.realestate.com.au/documentation/api/leads/usage/
class RawListingEnquiry::RealestateComAu < RawListingEnquiry
  def property_portal
    :real_commercial
  end

  def enquiry_id
    body['id']
  end

  def agency_id
    body['agencyId']
  end

  def received_at
    body['receivedAt']
  end

  def processed_at
    body['processedAt']
  end

  def enquiry_type
    body['type']
  end

  def message
    body['comments']
  end

  def requested_information
    body['requestedInformation']
  end

  def agent_recipients
    body['agentRecipients']
  end

  def listing_id
    body['listing']['id']
  end

  # The Reconnector > Property.internal_id
  def internal_id
    body['listing']['externalListingId']
  end

  def sender_first_name
    first_name
  end

  def sender_last_name
    last_name
  end

  def sender_email
    body['contactDetails']['email']
  end

  def sender_phone
    body['contactDetails']['phone']
  end

  def preferred_contact_method
    body['contactDetails']['preferredContactMethod']
  end

  def subject
    body['emailSubject']
  end

  def linked_agent
    account.agents.find_by(email: agent_recipients) || NilAgent.new
  end

  def linked_property
    # Try find a propery via the listing_id.
    # property = Property.joins(:real_commercial_listing, agent: :account)
    #                    .where(real_commercial_listing: { listing_id: listing_id }, accounts: { id: account_id })
    #                    .first
    listing = account.real_commercial_listings.find_by(listing_id: listing_id)
    return listing.property if listing.present? && listing.property.present?

    # If that fails, try find a property via the internal_id.
    account.properties.find_by(internal_id: internal_id)
  end

  def linked_contact
    account.contacts.find_by(first_name: sender_first_name, last_name: sender_last_name, email: sender_email)
  end

  private

  def first_name
    split_full_name[0]
  end

  def last_name
    split_full_name[1]
  end

  def split_full_name
    first, last = body['contactDetails']['fullName'].to_s.squish.split(/\s/, 2)
    [first, last]
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
