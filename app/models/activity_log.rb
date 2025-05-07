class ActivityLog < ApplicationRecord
  belongs_to :account
  belongs_to :agent, optional: true
  belongs_to :activityloggable, polymorphic: true

  validates :action, :result, presence: true

  default_scope { order(created_at: :desc) }

  def message
    [agent_name, self.action, self.activityloggable_type.downcase, self.body, self.result, created_at.to_formatted_s(:long)].join(' ')
  end

  def success?
    self.result == 'success'
  end

  def failed?
    self.result == 'failed'
  end

  private

  def agent_name
    return agent.name if agent_id.present?
  end
end

# == Schema Information
#
# Table name: activity_logs
#
#  account_id            :bigint           not null
#  action                :string
#  activityloggable_id   :bigint           not null
#  activityloggable_type :string           not null
#  agent_id              :bigint
#  body                  :string
#  created_at            :datetime
#  id                    :bigint           not null, primary key
#  payload               :string
#  result                :string
#
# Indexes
#
#  index_activity_logs_on_account_id        (account_id)
#  index_activity_logs_on_activityloggable  (activityloggable_type,activityloggable_id)
#  index_activity_logs_on_agent_id          (agent_id)
#
