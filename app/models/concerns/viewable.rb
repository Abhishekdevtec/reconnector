# frozen_string_literal: true

# Concern which adds helper methods to models which can be 'viewed' (or seen, or read)
module Viewable
  extend ActiveSupport::Concern

  HISTORY_DEPTH = 5

  included do
    has_many :views, as: :viewable, dependent: :destroy

    scope :viewed, -> { where(id: View.select(:viewable_id).where(viewable_type: model_name.to_s)) }
    scope :unviewed, -> { where.not(id: View.select(:viewable_id).where(viewable_type: model_name.to_s)) }
    scope :recently_viewed, -> { joins(:view).viewed.order(viewed_at: :desc).limit(HISTORY_DEPTH) }
  end

  def viewed?
    persisted? && View.exists?(viewable: self)
  end

  def viewed_by?(viewer)
    persisted? && View.exists?(viewable: self, viewed_by: viewer)
  end

  def mark_as_viewed(viewer:, at: DateTime.now)
    views.create(viewed_at: at, viewed_by: viewer)
  end

  def remark_as_viewed(viewer:, at: DateTime.now, delete_old: false)
    if viewed_by?(viewer)
      views.where(viewable: self, viewed_by: viewer).update(viewed_at: at)
    else
      mark_as_viewed(at:, viewer:)
    end
    # Remove old views
    return unless delete_old

    views.where(viewable: self,
                viewed_by: viewer).order(viewed_at: :desc).offset(HISTORY_DEPTH).delete_all
  end

  def mark_as_unviewed
    view.delete if viewed?
  end
end
