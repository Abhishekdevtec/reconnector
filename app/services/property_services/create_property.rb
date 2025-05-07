# frozen_string_literal: true

module PropertyServices
  class CreateProperty
    def create_property(property)
      if property.save
        # Call our asynchronous job
        PropertyJobs::CreatePropertyJob.perform_later(property.id)
        Result.new(created: true, property: property)
      else
        Result.new(created: false, property: property)
      end
    end

    # Our asynchronous job calls this method
    def after_create(property)
      # any notifications that need to be sent?

      # Add to activity
      property.activity_logs.create(account: property.account, agent: property.agent, action: 'created', result: 'success')
    end

    class Result
      attr_reader :property

      def initialize(created:, property: nil)
        @created = created
        @property = property
      end

      def created?
        @created
      end
    end
  end
end
