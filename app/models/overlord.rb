class Overlord < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable,
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  has_person_name

  def overlord?
    true
  end
end

# == Schema Information
#
# Table name: overlords
#
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  id                     :bigint           not null, primary key
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_overlords_on_email                 (email) UNIQUE
#  index_overlords_on_reset_password_token  (reset_password_token) UNIQUE
#
