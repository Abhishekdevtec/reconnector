# frozen_string_literal: true

class PortalListing::RealestateComAu < PortalListing
  # Get the upload processing status from Realestate.com.au
  def fetch_upload_processing_status_now(override_listing_id_presence: false)
    return if listing_id.present? && !override_listing_id_presence

    manage_response(property.account.realestate_com_au_client.fetch_listing_upload_report!(upload_id))
  end

  def fetch_upload_processing_status_later
    FetchUploadProcessingStatusJob.perform_later(self)
  end

  private

  def manage_response(response)
    update!(listing_id: JSON.parse(response.body)['listingId']) if response.code.eql? 200
    delete if response.code.eql?(404) && updated_at < 7.days.ago
  end

  class FetchUploadProcessingStatusJob < ApplicationJob
    def perform(portal_listing)
      portal_listing.fetch_upload_processing_status_now
    end
  end
end

# == Schema Information
#
# Table name: portal_listings
#
#  created_at  :datetime         not null
#  id          :bigint           not null, primary key
#  listing_id  :string
#  property_id :bigint           not null
#  type        :string
#  updated_at  :datetime         not null
#  upload_id   :string           not null
#
# Indexes
#
#  index_portal_listings_on_property_id  (property_id)
#
