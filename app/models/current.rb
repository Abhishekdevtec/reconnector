# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :agent
  attribute :account
  attribute :country
  attribute :state
end
