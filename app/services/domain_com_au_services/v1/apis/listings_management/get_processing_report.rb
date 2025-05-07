# frozen_string_literal: true

module DomainComAuServices
  module V1
    module Apis
      module ListingsManagement
        # See https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_getlistingreport
        module GetProcessingReport
          GetProcessingReportSucessResponse = Struct.new(:success?, :process_status, :agency_id, :provider_id, :provider_ad_id, :ad_id, :quality_score, :events, :versions, :http_status, :http_body)
          GetProcessingReportErrorResponse  = Struct.new(:success?, :http_status, :http_body)

          def get_processing_report(process_id)
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            endpoint = if Rails.env.production?
                         "v1/listings/processingReports/#{process_id}"
                       else
                         "sandbox/v1/listings/processingReports/#{process_id}"
                       end
            response = client.get(endpoint, headers)
            build_get_processing_report_response(response)
          end

          private

          def build_get_processing_report_response(response)
            if response_successful?(response)
              build_get_processing_report_success_response(response)
            else
              GetProcessingReportErrorResponse.new(false, response.status, response.body)
            end
          end

          def build_get_processing_report_success_response(response)
            json_body = JSON.parse(response.body)
            GetProcessingReportSucessResponse.new(
              true,
              json_body['processStatus'].to_sym,
              json_body['agencyId'],
              json_body['providerId'],
              json_body['providerAdId'],
              json_body['adId'].first,
              json_body['qualityScore'],
              json_body['events'],
              json_body['versions'],
              response.status,
              response.body
            )
          end
        end
      end
    end
  end
end
