# frozen_string_literal: true

class TabContainerComponent < ViewComponent::Base
  renders_many :tabs, TabComponent
end
