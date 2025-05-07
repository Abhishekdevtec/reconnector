# frozen_string_literal: true

require 'csv'

# Service which imports a Contact CSV file
module AppServices
  module Contacts
    class ImportCsv
      def initialize(filename, agent_id)
        @filename = filename
        @agent_id = agent_id
      end

      def call
        csv = CSV.parse(csv_content, encoding: 'UTF-8', headers: true, col_sep: ';')
        csv.each do |row|
          create_contact!(row)
        end
      end

      private

      def create_contact!(row)
        contact = case row['type']
                  when 'Company'
                    Business.new
                  when 'Individual'
                    Individual.new
                  end
        contact.agent = agent
        contact.account = account
        # contact.usages = row['classifications'].split(', ') if row['classifications'].present?
        contact_attributes.each do |attribute|
          contact.public_send("#{attribute}=", row[attribute]) if row[attribute].present?
        end
        result = ContactServices::CreateContact.new.create_contact(contact)
        if result.created?
          build_classifications(result.contact, row['classifications'].downcase.split(', ')) if row['classifications'].present?
          build_address(result.contact, row)
        else
          puts 'Error creating contact from row'
          p row
        end
      end

      def build_classifications(contact, classifications)
        classifications.each do |classification|
          contact.classifications.create!(account: account, name: classification)
        end
      end

      def build_address(contact, row)
        params = {
          line_1: [row['street_number'], row['street_address']].join(' '),
          city: row['city'],
          postal_code: row['postal_code'],
          state: row['state'],
          country: 'Australia'
          }
        contact.addresses.create!(params) if row['street_address'].present?
      end

      def csv_content
        File.read(@filename)
      end

      def agent
        @agent ||= Agent.find(@agent_id)
      end

      def account
        @account ||= agent.account
      end

      def contact_attributes
        %w(name phone mobile email)
      end
    end
  end
end
