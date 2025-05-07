# frozen_string_literal: true

# Job which goes out and fetches the enquiries
# since the last time it was run.
# See https://partner.realestate.com.au/documentation/api/leads/usage/
class Account::Integrations::RealestateComAu::FetchEnquiriesJob < ApplicationJob
  queue_as :default

  # If we cannot find the account, we can't do much.
  discard_on ActiveRecord::RecordNotFound

  around_perform do |job, block|
    log_start_and_finish(job, block)
  end

  # Find, in batches, the accounts which have the leads API enabled.
  # For each account, fetch the enquiries in a queued job.
  def perform
    Integrations::RealestateComAu::LeadsApi.find_each do |leads_api|
      leads_api.account.fetch_realestate_com_au_enquiries_now
    end
  end

  private

  def log_start_and_finish(_job, block)
    Rails.logger.info("[#{self.class}.perform] started.")
    block.call
    Rails.logger.info("[#{self.class}.perform] finished.")
  end
end
