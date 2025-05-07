# app/models/concerns/shareable.rb
# frozen_string_literal: true

# Provides a scope and helper
# method to models that have
# a boolean 'share' attribute
module Shareable
  extend ActiveSupport::Concern

  included do
    scope :shared, -> { where(share: true) }

    def shared?
      share
    end
  end
end
