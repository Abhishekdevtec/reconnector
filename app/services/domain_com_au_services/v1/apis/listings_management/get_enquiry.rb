# frozen_string_literal: true

module DomainComAuServices
  module V1
    module Apis
      module ListingsManagement
        # See https://developer.domain.com.au/docs/latest/apis/pkg_listing_management/references/enquiries_get/
        module GetEnquiry
          GetEnquirySucessResponse = Struct.new(:success?, :enquiry_type, :reference_id, :sender_first_name, :sender_last_name, :sender_email, :sender_phone_number, :http_status, :http_body)
          GetEnquiryErrorResponse  = Struct.new(:success?, :http_status, :http_body)

          def get_enquiry(enquiry_id)
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            endpoint = if Rails.env.production?
                        "v1/enquiries/#{enquiry_id}"
                      else
                        "sandbox/v1/enquiries/#{enquiry_id}"
                      end
            response = client.get(endpoint, headers)
            build_get_enquiry_response(response)
          end

          private

          def build_get_enquiry_response(response)
            if response_successful?(response)
              build_get_enquiry_success_response(response)
            else
              GetEnquiryErrorResponse.new(false, response.status, response.body)
            end
          end

          def build_get_enquiry_success_response(response)
            json_body = JSON.parse(response.body, symbolize_names: true)
            GetEnquirySucessResponse.new(
              true,
              json_body[:enquiryType],
              json_body[:referenceId],
              json_body[:sender][:firstName],
              json_body[:sender][:lastName],
              json_body[:sender][:email],
              json_body[:sender][:phoneNumber],
              response.status,
              response.body
            )
          end
        end
      end
    end
  end
end
