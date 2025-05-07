# frozen_string_literal: true

module ContactJobs
  class UpdateContactJob < ApplicationJob
    def perform(contact_id)
      @contact = Contact.find(contact_id)
    rescue ActiveRecord::RecordNotFound => e
      handle_missing_contact(contact_id, e)
    else
      ContactServices::UpdateContact.new.after_update(@contact)
    end

    private

    def handle_missing_contact(contact_id, exception)
      Rails.logger.error("[ContactJobs::UpdateContactJob(handle_missing_contact)] ERROR loading contact #{contact_id}")
      Rails.logger.info(exception.message)
    end
  end
end