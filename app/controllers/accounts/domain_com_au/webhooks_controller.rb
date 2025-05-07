#frozen_string_literal: true

module Accounts
  module DomainComAu
    # Domain.com.au webhooks controller
    # See https://developer.domain.com.au/docs/latest/apis/pkg_webhooks
    class WebhooksController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_account

      # See Verification chapter of https://developer.domain.com.au/docs/latest/apis/pkg_webhooks/guides/configuration
      def index
        return head :no_content if valid_verification_code?

        head :not_found
      end

      def create
        # Verify that the webhook is coming from Domain.com.au
        return head :not_found if @account.nil?
        return head :not_found if @account.domain_com_au_webhooks_verification_code.nil?
        return head :not_found if request_signature_missing?
        return head :not_found if signature_does_not_verify?

        # Process the webhook data asynchronously
        WebhookControllerAction.perform_later(@account.id, body)
        head :no_content
      end

      private

      def verification_code
        params['verification']
      end

      def valid_verification_code?
        verification_code.present? &&
          @account.domain_com_au_webhooks_verification_code.present? &&
          verification_code == @account.domain_com_au_webhooks_verification_code
      end

      def set_account
        @account = Account.find(params[:id]) if params[:id].present?
      end

      def signature
        request.headers['X-Domain-Signature']
      end

      def body
        @body ||= request.body.read
      end

      def request_signature_missing?
        signature.blank?
      end

      # Implement the verification of the signature using your secret key
      # https://developer.domain.com.au/docs/latest/apis/pkg_webhooks/guides/processing
      def signature_does_not_verify?
        validation_code = @account.domain_com_au_webhooks_verification_code
        signature != OpenSSL::HMAC.hexdigest('sha1', validation_code, body)
      end

      # Maybe not super clean to put this class here
      # but this job is not an application-wide
      # job but part of the domain...
      class WebhookControllerAction < ApplicationJob
        def perform(account_id, unhashed_params)
          InboundWebhook.create!(account_id: account_id, body: unhashed_params)
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "[#{self.class}] ERROR: Cannot create InboundWebhook with account_id '#{account_id}' and body '#{unhashed_params}'"
          Rails.logger.error e.record.errors
        end
      end
    end
  end
end
