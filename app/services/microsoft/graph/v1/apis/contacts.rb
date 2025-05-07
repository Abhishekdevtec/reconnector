# frozen_string_literal: true

module Microsoft
  module Graph
    module V1
      module Apis
        # Module to manage Graph Contacts
        # See https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0
        module Contacts
          # Must pass a Microsoft::Graph::V1::Models::Contact object
          # See https://learn.microsoft.com/en-us/graph/api/user-post-contacts?view=graph-rest-1.0&tabs=http
          def create_contact(contact)
            endpoint = 'me/contacts'
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            body = contact.to_json
            response = client.post(endpoint, body, headers)
            build_create_contact_response(response)
          end

          # Returns a Microsoft::Graph::V1::Models::Contact object
          # https://learn.microsoft.com/en-us/graph/api/contact-get?view=graph-rest-1.0&tabs=http
          def get_contact(id)
            endpoint = "me/contacts/#{id}"
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            response = client.get(endpoint, headers)
            body     = JSON.parse(response.body)
            OpenStruct.new(success?: response.status == 200, status: response.status, body: body, contact: Microsoft::Graph::V1::Models::Contact.new(body))
          end

          # https://learn.microsoft.com/en-us/graph/api/user-list-contacts?view=graph-rest-1.0&tabs=http
          def list_contacts
            endpoint = 'me/contacts'
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            response = client.get(endpoint, headers)
            OpenStruct.new(success?: response.status == 200, status: response.status, body: JSON.parse(response.body))
          end

          # https://learn.microsoft.com/en-us/graph/api/user-list-contacts?view=graph-rest-1.0&tabs=http
          def list_next_contents(next_link)
            response = client.get(next_link)
            OpenStruct.new(success?: response.status == 200, status: response.status, body: JSON.parse(response.body))
          end

          # https://learn.microsoft.com/en-us/graph/api/contact-update?view=graph-rest-1.0&tabs=http
          def update_contact(id, contact)
            endpoint = "me/contacts/#{id}"
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            body = contact.to_json
            response = client.patch(endpoint, body, headers)
            build_update_contact_response(response)
          end

          # https://learn.microsoft.com/en-us/graph/api/contact-delete?view=graph-rest-1.0&tabs=http
          def delete_contact(id)
            endpoint = "me/contacts/#{id}"
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            response = client.delete(endpoint, headers)
            body = JSON.parse(response.body)
            OpenStruct.new(success?: response.status == 204, status: response.status, body: body, contact: Microsoft::Graph::V1::Models::Contact.new(body))
          end

          private

          def build_create_contact_response(response)
            OpenStruct.new(
              success?: response.status == 201,
              created?: response.status == 201,
              status: response.status,
              body: JSON.parse(response.body)
            )
          end

          def build_update_contact_response(response)
            OpenStruct.new(
              success?: response.status == 200,
              updated?: response.status == 200,
              status: response.status,
              body: JSON.parse(response.body)
            )
          end
        end
      end
    end
  end
end
