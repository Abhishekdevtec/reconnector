# frozen_string_literal: true

module ContactServices
  # Business logic for creating
  # Contacts lives here
  class CreateContact
    def create_contact(contact)
      if contact.save
        # Call our asynchronous job
        ContactJobs::CreateContactJob.perform_later(contact.id)
        Result.new(created: true, contact: contact)
      else
        Result.new(created: false, contact: contact)
      end
    end

    # Our asynchronous job calls this method
    def after_create(contact)
      # Synchronise with Microsoft Office Online via the Graph API
      ::AppServices::Microsoft::Graph::CreateContact.new(contact).create_contact if contact.synchronize_with_office_online

      # any notifications that need to be sent?

      # Add to activity log
    end

    class Result
      attr_reader :contact

      def initialize(created:, contact: nil)
        @created = created
        @contact = contact
      end

      def created?
        @created
      end
    end
  end
end
