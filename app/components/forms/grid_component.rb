# frozen_string_literal: true

class Forms::GridComponent < ViewComponent::Base
  def initialize(columns: 6, gap: 6)
    @columns = columns
    @gap     = gap
  end

  private

  # Assuming that for smartphones < small,
  # we are going to use 1 column:
  # grid-cols-1
  def classes
    "mt-#{@gap} grid grid-cols-1 gap-y-#{@gap} gap-x-4 sm:grid-cols-#{@columns}"
  end
end
