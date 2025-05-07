# frozen_string_literal: true

class Table::SortableHeaderComponent < ViewComponent::Base
  def initialize(header:, url:)
    @header = header
    @url    = url
  end
end
