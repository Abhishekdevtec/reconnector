# frozen_string_literal: true

# Get the upload processing status
# for each property in a queued job.
# See https://partner.realestate.com.au/documentation/api/listings/usage/
# (GET https://api.realestate.com.au/listing/v1/upload/{uploadId})
class Property::Integrations::RealestateComAu::FetchUploadProcessingStatusJob < ApplicationJob
  queue_as :default

  # If we cannot find the property, we can't do much.
  discard_on ActiveRecord::RecordNotFound

  around_perform do |job, block|
    log_start_and_finish(job, block)
  end

  # Find, in batches, the properties which have been uploaded
  # but do not have a listing_id. Get the upload processing status
  # for each property in a queued job.
  def perform
    Account.find_each do |account|
      account.real_commercial_listings.unprocessed.find_each do |real_commercial_listing|
        real_commercial_listing.fetch_upload_processing_status_later
      end
    end
  end

  private

  def log_start_and_finish(_job, block)
    Rails.logger.info("[#{self.class}.perform] started.")
    block.call
    Rails.logger.info("[#{self.class}.perform] finished.")
  end
end
