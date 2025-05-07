class Agent < ApplicationRecord
  include CurrentAttributes
  include HasAddresses
  include AgentSupportForRea
  include AgentSupportForDomainComAu
  include AgentSupportForMicrosoftGraph

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  enum role: %i[agent admin account_manager]

  belongs_to :account
  has_one    :location,      dependent: :destroy, autosave: true
  has_many   :individuals,   dependent: :destroy
  has_many   :businesses,    dependent: :destroy
  has_many   :contacts,      dependent: :destroy
  has_many   :properties,    dependent: :destroy
  has_many   :contracts,     through: :properties
  has_many   :activity_logs, dependent: :nullify
  has_many   :listing_enquiries,           dependent: :destroy
  has_many   :retail_properties,           dependent: :destroy
  has_many   :industrial_properties,       dependent: :destroy
  has_many   :commercial_properties,       dependent: :destroy
  has_many   :residential_properties,      dependent: :destroy
  has_many   :matching_properties_emails,  dependent: :destroy
  has_many   :prospects_properties_emails, dependent: :destroy

  has_person_name

  accepts_nested_attributes_for :location
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  # Return associated Contacts
  # or which are shared by other Agents
  # of the same Account
  def visible_contacts
    Contact.where(account_id:, share: true).or(Contact.where(agent_id: id))
  end

  def visible_properties
    account.properties.where(share: true).or(account.properties.where(agent_id: id))
  end

  def time_zone
    return location.time_zone if location.present?

    'UTC'
  end

  def overlord?
    false
  end

  def recently_viewed_contacts
    # visible_contacts.where(views: View.where(viewable: visible_contacts).order(viewed_at: :desc).limit(5))
    visible_contacts.joins(:views).where(views: { viewable: visible_contacts,
                                                  viewed_by: self }).order('views.viewed_at desc').limit(5)
  end

  def recently_viewed_properties
    visible_properties.joins(:views).where(views: { viewable: visible_properties,
                                                    viewed_by: self }).order('views.viewed_at desc').limit(5)
  end
end

# == Schema Information
#
# Table name: agents
#
#  account_id             :bigint           not null
#  created_at             :datetime         not null
#  current_country        :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  current_state          :string
#  domain_com_au_agent_id :string
#  email                  :string           default(""), not null
#  encrypted_ews_password :string
#  encrypted_password     :string           default(""), not null
#  ews_username           :string
#  fax                    :string
#  first_name             :string
#  id                     :bigint           not null, primary key
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  mobile                 :string
#  phone                  :string
#  rea_agent_id           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("agent")
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_agents_on_account_id            (account_id)
#  index_agents_on_email                 (email) UNIQUE
#  index_agents_on_reset_password_token  (reset_password_token) UNIQUE
#
