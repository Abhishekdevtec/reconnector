# frozen_string_literal: true

class Forms::FileFieldComponent < ViewComponent::Base
  def initialize(form:, method:, options: {}, icon: :picture)
    @form    = form
    @method  = method
    @options = options.merge(classes)
    @icon    = icon
  end
  # <input id="file-upload" name="file-upload" type="file" class="sr-only">

  def classes
    { class: ' sr-only' }
  end
end
