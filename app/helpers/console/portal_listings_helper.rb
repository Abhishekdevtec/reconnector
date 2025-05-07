module Console::PortalListingsHelper
  def link_to_property(portal_listing)
    return 'No ID' if portal_listing.property_id.blank?

    if portal_listing.property.present?
      link_to portal_listing.property.internal_id, console_account_property_path(@account, portal_listing.property), target: '_blank'
    else
      "#{portal_listing.property_id} (ID)"
    end
  end
end
