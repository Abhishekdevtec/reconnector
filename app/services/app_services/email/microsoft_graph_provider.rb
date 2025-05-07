# frozen_string_literal: true

module AppServices
  module Email
    # Microsoft Graph email sending class which sends an email.
    #
    # The following params are required:
    #   access_token: the OAuth2 access token
    #   to: an array of email addresses
    #   subject: the email subject line
    #   body: HTML email body
    #   attachments: An array of file paths
    class MicrosoftGraphProvider < AppServices::Email::GenericProvider
      def send_message
        client.send_mail(subject, body, to, attachments)
      end

      private

      def client
        @client ||= ::Microsoft::Graph::V1::Client.new(access_token)
      end

      def access_token
        @access_token ||= @params[:access_token]
      end

      def subject
        @subject ||= @params[:subject]
      end

      def body
        @body ||= @params[:body]
      end

      def to
        @to ||= @params[:to]
      end

      def attachments
        @attachments ||= @params[:attachments]
      end
    end
  end
end
