# frozen_string_literal: true

# app/models/concerns/property_support_for_domain_com_au.rb
module PropertySupportForDomainComAu
  extend ActiveSupport::Concern

  def domain_com_au_listed?
    self.domain_com_au_listed
  end

  def domain_com_au_removable?
    self.domain_com_au_listing_id.present?
  end

  # TODO: Refactor this entire concern into a
  # property > portal listing concern
  # def update_domain_com_au_listing_id(listing_id)
  #   update(domain_com_au_listing_id: listing_id)
  #   update(domain_com_au_listed: listing_id.present?)
  # end
end
