# frozen_string_literal: true

module InboundWebhook::Processable
  extend ActiveSupport::Concern

  included do
    after_create_commit :process_later
  end

  def process_later
    InboundWebhook::ProcessJob.perform_later(self)
  end

  def process_now
    unhashed_params = JSON.parse(body, symbolize_names: true)

    unhashed_params.each do |params|
      case params[:resourceType]
      when 'listingProcessingReports'
        process_processing_report(params)
      when 'enquiries'
        process_enquiries(params)
      when 'heartbeat'
        process_heartbeat(params)
      else
        Rails.logger.info "[#{self.class}] INFO: #{params[:resourceType]} received. Will not process (unsupported)."
      end
    end
  end

  # A process can notify this webhook about the process outcome
  # which will either be a success or an error occured
  def update_processed_status(processed_successfully)
    if processed_successfully
      update(status: :processed)
    else
      update(status: :error)
    end
  end

  private

  # Monitoring of the status of submitted listings via the CRM endpoints.
  # This message is sent by Domain whenever a new listing processing report is available.
  def process_processing_report(params)
    Rails.logger.info "[#{self.class}] INFO: #{params[:resourceType]} received. Need to get the process report (#{params[:resourceType]})"
    AppServices::DomainComAu::FetchListingIdFromListingProcessReport.new(params[:resourceId], id).fetch_listing_id
  end

  # This message is sent by Domain whenever a listing enquiry is available.
  def process_enquiries(params)
    Rails.logger.info "[#{self.class}] INFO: #{params[:resourceType]} received. Need to get the enquiry data (#{params[:resourceType]})"
    AppServices::DomainComAu::FetchEnquiry.new(account_id, params[:resourceId], id).fetch_enquiry
  end

  def process_heartbeat(params)
    Rails.logger.info "[#{self.class}] INFO: #{params[:resourceType]} received."
    Rails.logger.info "[#{self.class}] INFO: #{params.inspect}"
  end
end

class InboundWebhook::ProcessJob < ApplicationJob
  def perform(inbound_webhook)
    inbound_webhook.process_now
  end
end
