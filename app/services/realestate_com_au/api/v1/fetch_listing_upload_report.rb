# frozen_string_literal: true

module RealestateComAu::Api::V1::FetchListingUploadReport
  def fetch_listing_upload_report!(upload_id)
    endpoint = "https://api.realestate.com.au/listing/v1/upload/#{upload_id}"
    options = {
      headers: {
        'Authorization': "Bearer #{access_token}",
        'Content-Type': 'application/json'
      }
    }
    HTTParty.get(endpoint, options)
  end
end
