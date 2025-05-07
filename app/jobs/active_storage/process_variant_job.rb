# frozen_string_literal: true

module ActiveStorage
  class ProcessVariantJob < ApplicationJob
    queue_as :default

    def perform(attachment_id, variant)
      attachement = ActiveStorage::Attachment.find(attachment_id)
      attachement.variant(variant).process unless attachement.variant(variant).processed?
    end
  end
end
