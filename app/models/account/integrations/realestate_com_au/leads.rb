# frozen_string_literal: true

module Account::Integrations::RealestateComAu::Leads
  extend ActiveSupport::Concern

  included do
    has_one :realestate_com_au_leads_api, class_name: 'Integrations::RealestateComAu::LeadsApi', dependent: :destroy

    accepts_nested_attributes_for :realestate_com_au_leads_api
  end

  def realestate_com_au_leads_api_enabled?
    return realestate_com_au_leads_api.enabled if realestate_com_au_leads_api.present?

    false
  end

  def enable_realestate_com_au_leads_api
    params = { enabled: true }
    if realestate_com_au_leads_api.present?
      realestate_com_au_leads_api.update(params)
    else
      create_realestate_com_au_leads_api(params)
    end
  end

  def disable_realestate_com_au_leads_api
    realestate_com_au_leads_api.update(enabled: false) if realestate_com_au_leads_api.present?
  end

  def fetch_realestate_com_au_enquiries_later
    FetchEnquiriesJob.perform_later(self)
  end

  def fetch_realestate_com_au_enquiries_now
    inject_paginated_requiries_since(realestate_com_au_leads_api.last_requested_at)
  end

  private

  class FetchEnquiriesJob < ApplicationJob
    def perform(account)
      account.fetch_realestate_com_au_enquiries_now
    end
  end

  def inject_paginated_requiries_since(timestamp)
    enquiries = []

    response = realestate_com_au_client.enquiries_since!(timestamp)
    if response.code == 200
      data = JSON.parse(response.body, symbolize_names: true)
      enquiries << data[:_embedded][:enquiries]

      # If there are pages of enquiries, fetch them too.
      enquiries << fetch_next_page_of_enquiries!(data[:_links][:next][:href]) unless data[:_links][:next][:href].nil?
    end

    ApplicationRecord.transaction do
      enquiries.flatten.each do |enquiry|
        RawListingEnquiry::RealestateComAu.create(
          account: self,
          body: enquiry
        )
      end
      realestate_com_au_leads_api.update(last_requested_at: Time.now)
    end
  rescue HTTParty::Error
    enquiries
  end

  def fetch_next_page_of_enquiries!(url)
    enquiries = []
    response = realestate_com_au_client.fetch_next_page_of_enquiries!(url)
    if response.code == 200
      data = JSON.parse(response.body, symbolize_names: true)
      enquiries << data[:_embedded][:enquiries]

      # If there are pages of enquiries, fetch them too.
      if data[:_links][:next][:href].present?
        enquiries << fetch_next_page_of_enquiries!(data[:_links][:next][:href])
      else
        return enquiries
      end
    end
  rescue HTTParty::Error
    enquiries
  ensure
    enquiries
  end

  def handle_response_for(response)
    return unless response.code == 200

    data = JSON.parse(response.body, symbolize_names: true)
    data[:_embedded][:enquiries].each do |enquiry|
      RawListingEnquiry::RealestateComAu.create(
        account: self,
        body: enquiry
      )
    end

    # If there are pages of enquiries, fetch them too.
    return if data[:_links][:next][:href].nil?

    next_page_response = realestate_com_au_client.fetch_next_page_of_enquiries!(data[:_links][:next][:href])
    handle_response_for(next_page_response)
  end
end
