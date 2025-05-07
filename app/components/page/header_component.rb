# frozen_string_literal: true

class Page::HeaderComponent < ViewComponent::Base
  def initialize(title, subtitle: nil, last_updated_at: nil)
    @title           = title
    @subtitle        = subtitle
    @last_updated_at = last_updated_at
  end
end
