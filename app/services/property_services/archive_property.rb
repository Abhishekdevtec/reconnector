# frozen_string_literal: true

module PropertyServices
  class ArchiveProperty
    def archive_property(property)
      if property.update({ archived_at: Time.now })
        # Call our asynchronous job
        # PropertyJobs::ArchivePropertyJob.perform_later(property.id)
        Result.new(archived: true, property: property)
      else
        Result.new(archived: false, property: property)
      end
    end

    # Our asynchronous job calls this method
    def after_archive(property)
      # Remove properties from the property portals?

      # Add to activity
      property.activity_logs.create(account: property.account, agent: property.agent, action: 'archived', result: 'success')
    end

    class Result
      attr_reader :property

      def initialize(archived:, property: nil)
        @archived = archived
        @property = property
      end

      def archived?
        @archived
      end
    end
  end
end
