# frozen_string_literal: true

class FormCollectionSelectComponent < ViewComponent::Base
  attr_accessor :form, :name, :options

  def initialize(form:, name:, collection:, attribute: :id, component_options: {}, **options)
    @form = form
    @name = name
    @collection = collection
    @attribute = attribute
    @component_options = component_options
    @options = if options[:class].blank?
                 options.merge(class_options)
               else
                 @options = options
               end
  end

  private

  def class_options
    { class: 'mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm' }
  end
end
