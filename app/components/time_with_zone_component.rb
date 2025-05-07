# frozen_string_literal: true

class TimeWithZoneComponent < ViewComponent::Base
  def initialize(date_time:, format: :long, time_zone: 'UTC')
    @date_time = date_time
    @format    = format
    @time_zone = time_zone
  end
end
