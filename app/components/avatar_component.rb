# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  def initialize(initials:, color:)
    @initials = initials
    @color = color
  end

end
