# frozen_string_literal: true

# Null class for Agents
class NilAgent
  def name
    'NilAgent'
  end

  def email
    ''
  end

  def persisted?
    false
  end

  def id
    raise 'This is a nil agent'
  end

  def blank?
    true
  end

  def present?
    false
  end

  def time_zone
    nil
  end

  def account
    raise 'This is a nil agent who has no account'
  end
end
