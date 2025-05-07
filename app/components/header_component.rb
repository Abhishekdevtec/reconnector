# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(tag: :h1, style: :h1, text:)
    @tag = tag
    @style = style
    @text = text
  end
end
