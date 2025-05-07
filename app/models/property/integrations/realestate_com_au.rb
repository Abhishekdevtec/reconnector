# frozen_string_literal: true

# Property helper methods for Realestate.com.au
# listing management
module Property::Integrations::RealestateComAu
  extend ActiveSupport::Concern

  included do
    has_one :real_commercial_listing, dependent: :delete, class_name: 'PortalListing::RealestateComAu'
  end

  def real_commercial_listing?
    PortalListing::RealestateComAu.exists?(property_id: id)
  end
end
