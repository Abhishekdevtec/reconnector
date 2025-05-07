# frozen_string_literal: true

module PropertyServices
  module Listings
    module DomainComAu
      class Uploader
        # Allows the app to asynchronously upload
        # a property to CommercialRealEstate.com.au
        # using their Domain.com API
        def upload_listing(property_id)
          PropertyJobs::Listings::DomainComAu::UploadListingJob.perform_later(property_id)
        end

        # Our asynchronous job calls this method
        def upload(property)
          listing_params = params(property)
          Rails.logger.info listing_params.inspect
          refresh_access_token(property.account.id) if property.account.need_to_update_refresh_token?
          domain_com_au = DomainComAuServices::UploadListing.new(listing_params)
          result = domain_com_au.upload_listing

          if result.success?
            # Domain.com.au returns a unique Listing ID
            # which we need to associate with the property
            # for future API interaction with this property
            property.update_column(:domain_com_au_listing_id, result.upload_id)
            property.update_column(:domain_com_au_listed, true)
            property.activity_logs.create(account: property.account, agent: property.agent, action: 'uploaded_domain_com_au_listing', result: 'success', payload: result.response)
          else
            add_error_to_activity_log(property, result)
          end
          result
        end

        private

        def params(property)
          {
            payload: DomainComAuServices::V1::Models::CommercialListing.new(property).as_json,
            access_token: property.account.domain_com_au_access_token
          }
        end

        def refresh_access_token(account_id)
          AppServices::DomainComAu::RefreshAccessToken.new({ account_id: account_id }).refresh_access_token
        end

        def add_error_to_activity_log(property, result)
          property.activity_logs.create(
            account: property.account,
            agent: property.agent,
            action: 'uploaded_domain_com_au_listing',
            result: 'failure',
            payload: result.response,
            body: result.response
          )
        end
      end
    end
  end
end
