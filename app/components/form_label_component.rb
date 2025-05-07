# frozen_string_literal: true
class FormLabelComponent < ViewComponent::Base
  attr_accessor :form, :name, :title, :options

  def initialize(form:, name:, title: nil, **options)
    @form = form
    @name = name
    @title = title
    @options = options.merge(class_options)
  end

  private

  def class_options
    { class: 'block text-sm font-medium text-gray-700' }
  end
end
