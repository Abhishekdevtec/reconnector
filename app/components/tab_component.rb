# frozen_string_literal: true

class TabComponent < ViewComponent::Base
  attr_accessor :name, :url, :active

  def initialize(name:, url:, active: false)
    @url    = url
    @name   = name
    @active = active
  end

  def to_html
    link
  end

  private

  def classes
    @active ? active_classes : inactive_classes
  end

  def active_classes
    'border-indigo-500 text-indigo-600 whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm'
  end

  def inactive_classes
    'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm'
  end
end
