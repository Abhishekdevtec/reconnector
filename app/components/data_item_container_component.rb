# frozen_string_literal: true

class DataItemContainerComponent < ViewComponent::Base
  renders_many :items, DataItemComponent

  def initialize(**options)
    @options = options
  end

  def item_container_classes
    if cycle_class_name?
      [base_container_classes, cycle('bg-gray-50', 'bg-white', name: cycle_class_name)].join(' ')
    else
      base_container_classes
    end
  end

  def cycle_class_name?
    !@options[:cycle_class_name].nil?
  end

  def cycle_class_name
    @options[:cycle_class_name]
  end

  def cycle_classes
    @options[:cycle_classes]
  end

  private

  def base_container_classes
    'px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6'
  end
end
