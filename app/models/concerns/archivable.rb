# app/models/concerns/archivable.rb
# frozen_string_literal: true

# Provides a scope and helper
# method to models that have
# a datetime 'archived_at' attribute
module Archivable
  extend ActiveSupport::Concern

  included do
    default_scope { where(archived_at: nil) }
    scope :only_archived, -> { unscope(where: :archived_at).where.not(archived_at: nil) }
    scope :with_archived, -> { unscope(where: :archived_at) }

    def archived?
      archived_at.present?
    end

    def archive
      self.update_column :archived_at, Time.now if has_attribute? :archived_at
    end

    def unarchive
      self.update_column :archived_at, nil if has_attribute? :archived_at
    end
  end

  class_methods do
    def archive_by(*args)
      where(*args).each(&:archive)
    end

    def unarchive_by(*args)
      where(*args).with_archived.each(&:unarchive)
    end
  end
end
