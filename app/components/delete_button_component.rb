# frozen_string_literal: true
class DeleteButtonComponent < ViewComponent::Base
  attr_accessor :text, :url

  def initialize(text:, url:)
    @text = text
    @url = url
  end
end
