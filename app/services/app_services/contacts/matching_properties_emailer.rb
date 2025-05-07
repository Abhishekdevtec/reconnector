# frozen_string_literal: true

# Service which sends an email with attachments
# and brochures to a contact
module AppServices
  module Contacts
    class MatchingPropertiesEmailer
      def initialize(matching_properties_email_params)
        @matching_properties_email_params = matching_properties_email_params
        @matching_properties_email = MatchingPropertiesEmail.new(@matching_properties_email_params)
        @brochures = []
        @downloaded_files = []
      end

      def valid?
        @matching_properties_email.valid?
      end

      def save
        @matching_properties_email.save
      end

      def object
        @matching_properties_email
      end

      def send_matching_properties_email
        generate_brochures if @matching_properties_email.attach_brochures?
        download_files
        send_email
        true
      rescue StandardError => e
        Rails.logger.error("[#{self.class}] ERROR sending email with matching properties (#{@matching_properties_email.property_ids.join(', ')})")
        Rails.logger.info("[#{self.class}] params : #{@matching_properties_email_params} ")
        Rails.logger.error e.backtrace
        false
      end

      private

      def generate_brochures
        @matching_properties_email.property_ids.each do |property_id|
          property = agent.properties.find(property_id)
          if property
            filepath = File.join(unique_local_directory, property.brochure.filename)
            @brochures << filepath if property.brochure.export_to(unique_local_directory)
          end
        end
      end

      def download_files
        @downloaded_files = []
        @matching_properties_email.files.each do |file|
          file.open do |f|
            source = f.path
            destination = File.join(unique_local_directory, file.filename.to_s)
            FileUtils.cp(source, destination)
            @downloaded_files << destination
          end
        end
      end

      def send_email
        ::Contacts::EmailMatchingPropertiesJob.perform_now(
          agent.id,
          contact.id,
          @matching_properties_email.property_ids,
          email,
          attached_files
        )
      end

      def unique_local_directory
        @unique_local_directory ||= @matching_properties_email.unique_local_directory
      end

      def email
        ApplicationController.render(
          partial: partial_path,
          layout: 'mailer',
          locals: {
            agent: agent,
            properties: properties,
            body: @matching_properties_email.body.to_trix_html
          },
          formats: [:html]
        )
      end

      def partial_path
        File.join('contacts', @matching_properties_email.class.to_s.pluralize.underscore, 'email')
      end

      def agent
        @agent ||= @matching_properties_email.agent
      end

      def contact
        @contact ||= @matching_properties_email.contact
      end

      def properties
        agent.properties.where(id: @matching_properties_email.property_ids)
      end

      def attached_files
        @downloaded_files + @brochures
      end
    end
  end
end
