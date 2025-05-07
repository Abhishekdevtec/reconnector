# frozen_string_literal: true

class Console::RawListingEnquiriesController < ConsoleController
  def index
    @raw_listing_enquiries = @account.raw_listing_enquiries.all.order(updated_at: :desc)
  end
end
