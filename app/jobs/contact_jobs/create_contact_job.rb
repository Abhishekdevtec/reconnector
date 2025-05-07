# frozen_string_literal: true

module ContactJobs
  class CreateContactJob < ApplicationJob
    def perform(contact_id)
      @contact = Contact.find(contact_id)
    rescue ActiveRecord::RecordNotFound => e
      handle_missing_contact(contact_id, e)
    else
      ContactServices::CreateContact.new.after_create(@contact)
    end

    private

    def handle_missing_contact(contact_id, exception)
      Rails.logger.error("[ContactJobs::CreateContactJob(handle_missing_contact)] ERROR loading contact #{contact_id}")
      Rails.logger.info(exception.message)
    end
  end
end