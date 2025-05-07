# frozen_string_literal: true

module RealestateComAu::Api::V1::FetchEnquiries
  def enquiries_since!(timestamp)
    endpoint = 'https://api.realestate.com.au/lead/v1/enquiries'
    options = {
      headers: {
        'Authorization': "Bearer #{access_token}",
        'Content-Type': 'application/json'
      },
      query: {
        since: timestamp.to_fs(:iso8601)
      }
    }
    HTTParty.get(endpoint, options)
  end

  def fetch_next_page_of_enquiries!(url)
    options = {
      headers: {
        'Authorization': "Bearer #{access_token}",
        'Content-Type': 'application/json'
      }
    }
    HTTParty.get(url, options)
  end
end
