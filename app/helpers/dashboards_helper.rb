# frozen_string_literal: true

module DashboardsHelper
  def friendly_greeting(first_name, time_zone)
    return t('dashboards.greeting', name: first_name) if time_zone.blank?

    if Time.now.in_time_zone(time_zone).hour.between?(0, 12)
      t('dashboards.good_morning', name: first_name)
    elsif Time.now.in_time_zone(time_zone).hour.between?(13, 17)
      t('dashboards.good_afternoon', name: first_name)
    else
      t('dashboards.good_evening', name: first_name)
    end
  end
end
