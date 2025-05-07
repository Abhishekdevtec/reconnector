# frozen_string_literal: true

module AppServices
  module Microsoft
    module Graph
      # Class which updates a contact over on
      # Microsoft Graph
      # See https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0
      class UpdateContact
        def initialize(contact)
          @contact = contact
          @agent   = @contact.agent
        end

        def update_contact
          # Create a new contact if needed
          if @contact.microsoft_graph_data_missing? || @contact.microsoft_graph_data.object_id.blank?
            ::AppServices::Microsoft::Graph::CreateContact.new(@contact).create_contact
          else
            response = client.update_contact(@contact.microsoft_graph_data.object_id, microsoft_graph_contact_params)
            if response.error
              Rails.logger.error "[#{self.class}] ERROR updating contact (#{@contact.id}) : #{response.error}"
            else
              Rails.logger.info "[#{self.class}] Updated contact (#{@contact.id})"
              @contact.build_or_update_microsoft_graph_object_data(response.body)
            end
          end
        end

        private

        def client
          @client ||= ::Microsoft::Graph::V1::Client.new(access_token)
        end

        def access_token
          @access_token ||= @agent.microsoft_graph_token.access_token
        end

        def microsoft_graph_contact_params
          {
            businessAddress: business_address,
            businessHomePage: @contact.url,
            businessPhones: [@contact.phone],
            categories: @contact.classification_names,
            companyName: @contact.business_name,
            displayName: @contact.name,
            emailAddresses: email_addresses,
            givenName: @contact.first_name,
            home_address: home_address,
            initials: @contact.name.initials,
            jobTitle: @contact.job_title,
            mobilePhone: @contact.mobile,
            otherAddress: other_address,
            personalNotes: @contact.notes.to_plain_text,
            profession: @contact.job_title,
            surname: @contact.last_name
          }.compact_blank
        end

        def business_address
          # ::Microsoft::Graph::V1::Models::PhysicalAddress.new(params[:business_address])
          nil
        end

        def email_addresses
          params = {
            name: @contact.name,
            address: @contact.email
          }
          [::Microsoft::Graph::V1::Models::EmailAddress.new(params).to_h]
        end

        def home_address
          # ::Microsoft::Graph::V1::Models::PhysicalAddress.new(params[:home_address])
          nil
        end

        def other_address
          # ::Microsoft::Graph::V1::Models::PhysicalAddress.new(params[:other_address])
          nil
        end
      end
    end
  end
end
