# frozen_string_literal: true

class DataItemComponent < ViewComponent::Base
  include ActionView::Helpers

  def initialize(name:, value:, **options)
    @name = name
    @value = value
    @options = options
  end
end
