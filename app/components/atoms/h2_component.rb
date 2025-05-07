# frozen_string_literal: true

class Atoms::H2Component < ViewComponent::Base
  def initialize(text:)
    @text = text
  end
end
