# frozen_string_literal: true

module DomainComAu
  module Webhook
    # Class which represents a Domain.com.au Webhook Subscription
    # see https://developer.domain.com.au/docs/v1/apis/pkg_webhooks/
    class Subscription
      include ActiveModel::Model

      attr_accessor :id, :subscriber_id, :resource_type, :owner_id, :owner_type
    end
  end
end
