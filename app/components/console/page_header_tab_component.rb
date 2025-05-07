# frozen_string_literal: true

class Console::PageHeaderTabComponent < ViewComponent::Base
  def initialize(title:, path:)
    @title  = title
    @path   = path
  end

  private

  def classes
    return 'border-indigo-500 text-indigo-600 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm' if active?

    'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm'
  end

  def active?
    current_page?(@path)
  end
end
