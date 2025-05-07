# frozen_string_literal: true

module Agent::CurrentAttributes
  include ActiveSupport::Concern

  def update_current_country(country)
    update_attribute(:current_country, country)
  end

  def update_current_state(state)
    update_attribute(:current_state, state)
  end
end
