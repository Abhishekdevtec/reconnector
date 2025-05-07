# frozen_string_literal: true

module Console
  class PageHeaderComponent < ViewComponent::Base
    renders_many :buttons, Console::PageHeaderButtonComponent
    renders_many :tabs, Console::PageHeaderTabComponent

    def initialize(title)
      @title = title
    end
  end
end
