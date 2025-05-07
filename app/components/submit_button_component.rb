# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(text:, icon:)
    @text = text
    @icon = icon
  end

  private

  def icon
    case @icon
    when :save
      ''.html_safe
    when :email
      '<svg class="-ml-1 mr-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"><path d="M2.003 5.884L10 9.882l7.997-3.998A2 2 0 0016 4H4a2 2 0 00-1.997 1.884z" /><path d="M18 8.118l-8 4-8-4V14a2 2 0 002 2h12a2 2 0 002-2V8.118z" /></svg>'.html_safe
    end
  end
end
