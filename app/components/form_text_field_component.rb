# frozen_string_literal: true
class FormTextFieldComponent < ViewComponent::Base
  attr_accessor :form, :name, :type, :options

  def initialize(form:, name:, type: :text, **options)
    @form = form
    @name = name
    @type = type
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

  def field_type
    case @type
    when :text
      'text_field'
    when :phone
      'phone_field'
    when :email
      'email_field'
    when :date
      'date_field'
    when :password
      'password_field'
    when :number
      'number_field'
    end
  end
end
