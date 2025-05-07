# frozen_string_literal: true

class AccessRequest < ApplicationRecord
  validates :first_name, :last_name, :company, :agent_count, :email, presence: true

  has_person_name
end

# == Schema Information
#
# Table name: access_requests
#
#  agent_count :string
#  company     :string
#  created_at  :datetime         not null
#  email       :string
#  first_name  :string
#  id          :bigint           not null, primary key
#  last_name   :string
#  phone       :string
#  request     :text
#  updated_at  :datetime         not null
#
