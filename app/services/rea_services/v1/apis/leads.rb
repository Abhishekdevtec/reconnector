# frozen_string_literal: true

module ReaServices
  module V1
    module Apis
      module Leads
        # Get enquiries
        # https://partner.realestate.com.au/documentation/api/leads/explore/
        def get_enquiries(access_token, params = {})
          endpoint = 'https://api.realestate.com.au/lead/v1/enquiries'
          options  = {
            headers: {
              'Authorization': "Bearer #{access_token}",
              'Content-Type': 'application/json'
            },
            query: params
          }
          HTTParty.get(endpoint, options)
        end

        # Get enquiry
        # https://partner.realestate.com.au/documentation/api/leads/explore/
        def get_enquiry(access_token, enquiry_id)
          endpoint = "https://api.realestate.com.au/lead/v1/enquiries/#{enquiry_id}"
          options  = {
            headers: {
              'Authorization': "Bearer #{access_token}",
              'Content-Type': 'application/json'
            }
          }
          HTTParty.get(endpoint, options)
        end

        # Get enquiry count
        # https://partner.realestate.com.au/documentation/api/leads/explore/
        def get_enquiry_count(access_token, params = {})
          endpoint = 'https://api.realestate.com.au/lead/v1/enquiries/count'
          options  = {
            headers: {
              'Authorization': "Bearer #{access_token}",
              'Content-Type': 'application/json'
            },
            query: params
          }
          HTTParty.get(endpoint, options)
        end
      end
    end
  end
end
