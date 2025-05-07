# frozen_string_literal: true
class PopupMenuItemComponent < ViewComponent::Base
  attr_accessor :name, :url

  def initialize(name:, url:, type: :normal, **options)
    @url    = url
    @name   = name
    @type   = type
    @options = if options[:class].blank?
                 options.merge(class_options)
               else
                 @options = options
               end
  end

  private

  def class_options
    case @type
    when :delete
      delete_classes
    else
      normal_classes
    end
  end

  def normal_classes
    { class: 'text-gray-700 hover:bg-gray-100 hover:text-gray-900 flex justify-between px-4 py-2 text-sm' }
  end

  def delete_classes
    { class: 'text-red-700 hover:bg-red-50 hover:text-red-900 flex justify-between px-4 py-2 text-sm' }
  end
end
