# frozen_string_literal: true

module ContactServices
  # Business logic for updating
  # Contacts lives here
  class UpdateContact
    def update_contact(contact, update_params)
      if contact.update(update_params)
        # Call our asynchronous job
        ContactJobs::UpdateContactJob.perform_later(contact.id)
        Result.new(updated: true, contact: contact)
      else
        Result.new(updated: false, contact: contact)
      end
    end

    # Our asynchronous job calls this method
    def after_update(contact)
      # Synchronise with Microsoft Office Online via the Graph API
      ::AppServices::Microsoft::Graph::UpdateContact.new(contact).update_contact if contact.synchronize_with_office_online

      # any notifications that need to be sent?

      # Add to activity log
    end

    class Result
      attr_reader :contact

      def initialize(updated:, contact: nil)
        @updated = updated
        @contact = contact
      end

      def updated?
        @updated
      end
    end
  end
end