# frozen_string_literal: true

class ComboboxComponent < ViewComponent::Base
  attr_accessor :form, :name, :collection

  def initialize(form:, name:, collection:)
    @form = form
    @name = name
    @collection = collection
  end
end
