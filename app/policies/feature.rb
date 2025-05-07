# frozen_string_literal: true
#
# This is a small gate that keep all Messaging-related work "off" in production until everything is ready.
class Feature
  def self.enabled?(feature_name)
    case feature_name.to_sym
    when :messaging
      Feature.disabled_in_production
    else
      true
    end
  end

  def self.disabled_in_production
    !Rails.env.production?
  end
end
