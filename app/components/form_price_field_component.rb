# frozen_string_literal: true
class FormPriceFieldComponent < ViewComponent::Base
  attr_accessor :form, :name, :symbol, :abbreviation, :min, :options

  def initialize(form:, name:, symbol: '$', **options)
    @min = min
    @form = form
    @name = name
    @symbol = symbol
    @options = merge_options(options)
  end

  private

  def merge_options(options)
    @options = options
    @options = @options.merge(class_options) if options[:class].blank?
    @options = @options.merge(placeholder_options) if options[:placeholder].blank?
  end

  def class_options
    { class: 'focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md' }
  end

  def placeholder_options
    { placeholder: '0.00' }
  end
end
