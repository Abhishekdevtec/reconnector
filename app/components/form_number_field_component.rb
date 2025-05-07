# frozen_string_literal: true
class FormNumberFieldComponent < ViewComponent::Base
  attr_accessor :form, :name, :type, :options

  def initialize(form:, name:, **options)
    @form = form
    @name = name
    @options = if options[:class].blank?
                 options.merge(class_options)
               else
                 @options = options
               end
  end

  private

  def class_options
    { class: 'mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md' }
  end
end
