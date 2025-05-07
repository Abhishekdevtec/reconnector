# frozen_string_literal: true

# Service which sends an email with attachments
# and brochures to contacts
module AppServices
  module Properties
    class ProspectsPropertiesEmailer
      def initialize(prospects_properties_email_params)
        @prospects_properties_email_params = prospects_properties_email_params
        @prospects_properties_email = ProspectsPropertiesEmail.new(@prospects_properties_email_params)
        @brochures = []
        @downloaded_files = []
      end

      def valid?
        @prospects_properties_email.valid?
      end

      def save
        @prospects_properties_email.save
      end

      def object
        @prospects_properties_email
      end

      def send_prospects_properties_email
        generate_brochures if @prospects_properties_email.attach_brochures?
        download_files
        send_emails
        true
      rescue StandardError => e
        Rails.logger.error("[#{self.class}] ERROR sending propsect emails with matching properties (#{@prospects_properties_email.property_ids.join(', ')})")
        Rails.logger.info("[#{self.class}] params : #{@prospects_properties_email_params} ")
        Rails.logger.error e.backtrace
        false
      end

      private

      def generate_brochures
        @prospects_properties_email.property_ids.each do |property_id|
          property = agent.properties.find(property_id)
          if property
            filepath = File.join(unique_local_directory, property.brochure.filename)
            @brochures << filepath if property.brochure.export_to(unique_local_directory)
          end
        end
      end

      def download_files
        @downloaded_files = []
        @prospects_properties_email.files.each do |file|
          file.open do |f|
            source = f.path
            destination = File.join(unique_local_directory, file.filename.to_s)
            FileUtils.cp(source, destination)
            @downloaded_files << destination
          end
        end
      end

      def send_emails
        contacts.each do |contact|
          ::Properties::EmailProspectsPropertiesJob.perform_now(
            agent.id,
            contact.id,
            @prospects_properties_email.property_ids,
            email(contact),
            attached_files
          )
        end
      end

      def unique_local_directory
        @unique_local_directory ||= @prospects_properties_email.unique_local_directory
      end

      def email(contact)
        ApplicationController.render(
          partial: partial_path,
          layout: 'mailer',
          locals: {
            agent: agent,
            contact: contact,
            properties: properties,
            body: @prospects_properties_email.body.to_trix_html
          },
          formats: [:html]
        )
      end

      def partial_path
        File.join('properties', @prospects_properties_email.class.to_s.pluralize.underscore, 'email')
      end

      def agent
        @agent ||= @prospects_properties_email.agent
      end

      def contacts
        @contacts ||= Contact.find(@prospects_properties_email.contact_ids)
      end

      def properties
        agent.properties.where(id: @prospects_properties_email.property_ids)
      end

      def attached_files
        @downloaded_files + @brochures
      end
    end
  end
end
