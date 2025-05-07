# frozen_string_literal: true

# Individual model
class Individual < Contact
  validate do |individual|
    MinimumIndividualRequiredFields.new(individual).validate
  end

  belongs_to :business, optional: true

  scope :visible_by, ->(agent) { where(share: true).or(Individual.where(agent_id: agent.id)) }

  has_person_name

  def initial
    return last_name.first unless last_name.nil?
    return first_name.first unless first_name.nil?

    '-'
  end
end

# == Schema Information
#
# Table name: contacts
#
#  account_id                     :bigint           not null
#  agent_id                       :bigint           not null
#  business_id                    :bigint
#  business_name                  :string
#  classifiable_id                :bigint
#  classifiable_type              :string
#  created_at                     :datetime         not null
#  email                          :string
#  ews_change_key                 :string
#  ews_created_at                 :datetime
#  ews_imported_from_ews          :boolean          default(FALSE)
#  ews_item_id                    :string
#  ews_last_modified_at           :datetime
#  ews_received_at                :datetime
#  ews_sent_at                    :datetime
#  fax                            :string
#  first_name                     :string
#  id                             :bigint           not null, primary key
#  job_title                      :string
#  last_name                      :string
#  legal_name                     :string
#  mobile                         :string
#  notes                          :text
#  phone                          :string
#  registration                   :string
#  share                          :boolean          default(FALSE)
#  source_id                      :string
#  synchronize_with_office_online :boolean          default(FALSE)
#  type                           :string
#  updated_at                     :datetime         not null
#  url                            :string
#
# Indexes
#
#  index_contacts_on_account_id    (account_id)
#  index_contacts_on_agent_id      (agent_id)
#  index_contacts_on_business_id   (business_id)
#  index_contacts_on_classifiable  (classifiable_type,classifiable_id)
#
