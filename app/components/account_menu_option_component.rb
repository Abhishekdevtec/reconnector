# frozen_string_literal: true
class AccountMenuOptionComponent < ViewComponent::Base
  attr_accessor :name, :url, :options

  def initialize(name:, url:, icon: :none, active: false, **options)
    @url    = url
    @name   = name
    @icon   = icon
    @active = active
    @options = if options[:class].blank?
                 options.merge(class_options)
               else
                 @options = options
               end
  end

  private

  def class_options
    @active ? active_classes : inactive_classes
  end

  def active_classes
    { class: 'border-indigo-500 text-indigo-600 group inline-flex items-center py-4 px-1 border-b-2 font-medium text-sm' }
  end

  def inactive_classes
    { class: 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 group inline-flex items-center py-4 px-1 border-b-2 font-medium text-sm' }
  end
end
