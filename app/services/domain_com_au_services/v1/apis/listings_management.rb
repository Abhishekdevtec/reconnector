# frozen_string_literal: true

module DomainComAuServices
  module V1
    module Apis
      module ListingsManagement
        include ListingsManagement::GetEnquiry
        include ListingsManagement::GetProcessingReport

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/agencies_createtestagency
        def create_test_agency(sandbox_environment: false)
          return BadEnvironnementError if !sandbox_environment # We don't want to create a test agency in Production

          headers = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
          request(http_method: :post, endpoint: 'sandbox/v1/agencies/_testAgency', headers: headers)
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_get
        def get_listings(id:, params: {})
          request(http_method: :get, endpoint: "v1/listings/#{id}", params: params)
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_upsertcommerciallisting
        def put_commercial_listing(payload)
          request(http_method: :put, endpoint: 'v1/listings/commercial', payload: payload)
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_getlistingreport
        # Use the 'id' returned from PUT listing
        def fetch_processing_report(process_id)
          headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
          endpoint = if Rails.env.production?
                       "v1/listings/processingReports/#{process_id}"
                     else
                       "sandbox/v1/listings/processingReports/#{process_id}"
                     end
          request(http_method: :get, endpoint: endpoint, headers: headers)
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_updateoffmarketdetails
        def post_listings_offmarket(id:, payload:)
          request(http_method: :post, endpoint: "v1/listings/#{id}/offmarket", payload: payload)
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_updateoffmarketdetails
        def destroy_listing(listing_id, body)
          headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
          endpoint = if Rails.env.production?
                       "v1/listings/#{listing_id}/offmarket"
                     else
                       "sandbox/v1/listings/#{listing_id}/offmarket"
                     end
          request(http_method: :post, endpoint: endpoint, body: body, headers: headers)
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/listings_getlistingstatistics
        def get_listing_statistics(id)
          request(http_method: :get, endpoint: "v1/listings/#{id}/statistics")
        end

        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/me_profile/
        def get_me
          request(http_method: :get, endpoint: 'v1/me')
        end
        # https://developer.domain.com.au/docs/v1/apis/pkg_listing_management/references/me_getmyagencies/
        def get_my_agencies
          request(http_method: :get, endpoint: 'v1/me/agencies')
        end
      end
    end
  end
end
