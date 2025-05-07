# frozen_string_literal: true

module Microsoft
  module Graph
    module V1
      module Apis
        # Module to manage Graph Mail calls
        module Mail
          # See https://learn.microsoft.com/en-us/graph/api/user-sendmail?view=graph-rest-1.0&tabs=http
          def send_mail(subject, body, to_recipients, attachments = nil)
            endpoint = 'me/sendMail'
            headers  = { 'Authorization': "Bearer #{@oauth_token}", 'Content-Type': 'application/json' }
            message  = {
              'subject': subject,
              'body': {
                'contentType': 'HTML',
                'content': body
              },
              # 'toRecipients': build_send_mail_recipients(to_recipients)
              'toRecipients': [{ 'emailAddress': { 'address': to_recipients } }]
            }
            message.merge!(build_send_mail_attachments(attachments)) if attachments
            body = { 'message': message }
            response = client.post(endpoint, body.to_json, headers)
            build_send_mail_response(response)
          end

          private

          def build_send_mail_recipients(to_array)
            recipients = []
            to_array.each do |recipient|
              recipients << { 'emailAddress': { 'address': recipient } }
            end
            recipients
          end

          def build_send_mail_attachments(attachments)
            ret = []
            attachments.each do |attachment|
              data = File.open(attachment).read
              ret << {
                '@odata.type': '#microsoft.graph.fileAttachment',
                'name': File.basename(attachment),
                'contentType': 'text/plain',
                'contentBytes': Base64.strict_encode64(data)
              }
            end
            { 'attachments': ret }
          end

          def build_send_mail_response(response)
            OpenStruct.new(
              success?: response.status == 202,
              sent?: response.status == 202,
              status: response.status,
              body: response.body
            )
          end
        end
      end
    end
  end
end
