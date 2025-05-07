# frozen_string_literal: true

module PropertyServices
  class UpdateProperty
    def update_property(property, property_params)
      if property.update(property_params)
        # Call our asynchronous job
        PropertyJobs::UpdatePropertyJob.perform_later(property.id)
        Result.new(updated: true, property: property)
      else
        add_error_to_activity_log(property)
        Result.new(updated: false, property: property)
      end
    end

    # Our asynchronous job calls this method
    def after_update(property)
      # any notifications that need to be sent?

      # Add to activity log
      property.activity_logs.create(account: property.account, agent: property.agent, action: 'updated', result: 'success')
    end

    class Result
      attr_reader :property

      def initialize(updated:, property: nil)
        @updated = updated
        @property = property
      end

      def updated?
        @updated
      end
    end

    private

    def add_error_to_activity_log(property)
      property.activity_logs.create(
        account: property.account,
        agent: property.agent,
        action: 'updated',
        result: 'failure',
        payload: property.errors.to_s,
        body: property.errors.full_messages.to_sentence
      )
    end
  end
end
