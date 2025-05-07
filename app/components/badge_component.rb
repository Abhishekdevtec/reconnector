# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  def initialize(text:, color: :green)
    @text = text
    @color = color
  end

  def bg_color
    case @color
    when :gray
      'bg-gray-100'
    when :red
      'bg-red-100'
    when :green
      'bg-green-100'
    when :blue
      'bg-blue-100'
    else
      raise 'Background color not supported'
    end
  end

  def text_color
    case @color
    when :gray
      'text-gray-800'
    when :red
      'text-red-800'
    when :green
      'text-green-800'
    when :blue
      'text-blue-800'
    else
      raise 'Text color not supported'
    end
  end
end
