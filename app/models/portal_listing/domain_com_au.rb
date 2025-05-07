# frozen_string_literal: true

class PortalListing::DomainComAu < PortalListing
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
