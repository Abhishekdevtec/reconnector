# frozen_string_literal: true

class ErrorComponent < ViewComponent::Base
  def initialize(errors)
    @errors = errors
  end

  private

  def title
    "There is #{pluralize(@errors.count, 'error')} with your submission"
  end
end
