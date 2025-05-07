# frozen_string_literal: true

module PropertyJobs
  class UpdatePropertyJob < ApplicationJob
    def perform(property_id)
      @property = Property.find(property_id)
    rescue ActiveRecord::RecordNotFound => e
      handle_missing_property(property_id, e)
    else
      PropertyServices::UpdateProperty.new.after_update(@property)
    end

    private

    def handle_missing_property(property_id, exception)
      Rails.logger.error("[PropertyJobs::UpdatePropertyJob(handle_missing_property)] ERROR loading property #{property_id}")
      Rails.logger.info(exception.message)
    end
  end
end