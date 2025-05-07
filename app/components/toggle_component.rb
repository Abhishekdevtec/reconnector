# frozen_string_literal: true

class ToggleComponent < ViewComponent::Base
  attr_reader :title, :url

  def initialize(activated, title:, url:)
    @activated = activated
    @title = title
    @url = url
  end

  def activated?
    !!@activated
  end

  def method
    activated? ? :delete : :create
  end
end
