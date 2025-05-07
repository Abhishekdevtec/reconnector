# frozen_string_literal: true

module Console
  class FormSectionComponent < ViewComponent::Base
    def initialize(header:, description:)
      @header = header
      @description = description
    end
  end
end
