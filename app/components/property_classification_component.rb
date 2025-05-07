# frozen_string_literal: true
class PropertyClassificationComponent < ViewComponent::Base
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
    'inline-flex items-center px-6 py-3 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 ring-2 ring-offset-2 ring-indigo-500'
  end

  def inactive_classes
    'inline-flex items-center px-6 py-3 border border-transparent shadow-sm text-base font-medium rounded-md text-grey-500 border border-gray-300 bg-white shadow-sm cursor-pointer hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500'
  end
end
