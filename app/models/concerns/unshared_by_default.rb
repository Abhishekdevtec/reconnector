# frozen_string_literal: true

# Module which sets the 'share' attribute
# to false when creating a new model
module UnsharedByDefault
  extend ActiveSupport::Concern

  included do
    attribute :share, default: false
  end
end