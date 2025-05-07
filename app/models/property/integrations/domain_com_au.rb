# frozen_string_literal: true

# Property helper methods for Domain.com.au
# listing management
module Property::Integrations::DomainComAu
  extend ActiveSupport::Concern

  included do
    has_one :domain_com_au_listing, dependent: :delete, class_name: 'PortalListing::DomainComAu'
  end

  def domain_com_au_listing?
    PortalListing::DomainComAu.exists?(property_id: id)
  end

  def update_domain_com_au_listing_id(listing_id)
    if domain_com_au_listing?
      domain_com_au_listing.update!(listing_id: listing_id)
    else
      raise 'Cannot update Domain.com.au listing ID because the property does not have an associated Domain.com.au listing object.' unless domain_com_au_listing?
    end
  end
end
