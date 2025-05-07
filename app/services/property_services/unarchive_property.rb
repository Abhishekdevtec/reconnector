# frozen_string_literal: true

module PropertyServices
  class UnarchiveProperty
    def unarchive_property(property)
      if property.update({ archived_at: nil })
        # Call our asynchronous job
        # PropertyJobs::UnrchivePropertyJob.perform_later(property.id)
        Result.new(unarchived: true, property: property)
      else
        Result.new(unarchived: false, property: property)
      end
    end

    # Our asynchronous job calls this method
    def after_unarchive(property)
      # Add to activity
      property.activity_logs.create(account: property.account, agent: property.agent, action: 'unarchived', result: 'success')
    end

    class Result
      attr_reader :property

      def initialize(unarchived:, property: nil)
        @unarchived = unarchived
        @property = property
      end

      def unarchived?
        @unarchived
      end
    end
  end
end
