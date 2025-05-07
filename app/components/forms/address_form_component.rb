# frozen_string_literal: true

class Forms::AddressFormComponent < ViewComponent::Base
  def initialize(form:, address_type:, description: nil)
    @form         = form
    @address_type = address_type
    @description  = description
  end
end
