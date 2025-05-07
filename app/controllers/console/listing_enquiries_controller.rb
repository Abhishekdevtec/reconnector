# frozen_string_literal: true

class Console::ListingEnquiriesController < ConsoleController
  def index
    @listing_enquiries = @account.listing_enquiries.all.order(enquired_at: :desc)
  end
end
