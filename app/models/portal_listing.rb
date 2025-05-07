# frozen_string_literal: true

# Holds the data for a property listing on a property portal
# site like Domain.com.au or Realestate.com.au
class PortalListing < ApplicationRecord
  belongs_to :property

  validates :upload_id, presence: true

  scope :unprocessed, -> { where.not(upload_id: nil).where(listing_id: nil) }
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
