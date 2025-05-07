class Property < ApplicationRecord
  include ::PgSearch::Model
  include Archivable
  include Documentable
  include HasBrochureImages
  include HasMoneytaryAttributes
  include NormalizeBlankValues
  include PropertySupportForDomainComAu
  include PropertySupportForRea
  include Shareable
  include Viewable

  include Integrations::RealestateComAu
  include Integrations::DomainComAu

  after_create_commit :generate_internal_id
  before_save :calculate_building_area

  has_many :activity_logs,                as: :activityloggable
  has_many :property_contacts,            dependent: :destroy
  has_many :prospect_notification_emails, dependent: :destroy

  has_many :contacts,                     through: :property_contacts

  has_one  :contract,                     dependent: :destroy

  has_many :portal_listings,              dependent: :delete_all
  has_many :listing_enquiries,            dependent: :destroy

  validates :country, presence: true
  validates :type, presence: true
  validates :usages, length: { maximum: 3 }

  # TODO: Remove these validations once we have
  # extrated the listing data
  validates :domain_com_au_listing_id, uniqueness: true, allow_nil: true
  validates :domain_com_au_process_id, uniqueness: true, allow_nil: true

  belongs_to :agent

  delegate :account, to: :agent
  delegate :account_id, to: :agent
  delegate :for_sale?, to: :contract, allow_nil: true
  delegate :for_lease?, to: :contract, allow_nil: true

  default_scope { order(created_at: :desc) }
  scope :recent, -> { order(created_at: :desc).limit(5) }

  has_rich_text :brochure_description
  has_rich_text :fit_out
  has_rich_text :furniture
  has_rich_text :notes
  has_rich_text :website_description

  SM_BROCHURE_IMAGE_DIMENSIONS   = [394, 497]
  BASE_BROCHURE_IMAGE_DIMENSIONS = [398, 272]
  LG_BROCHURE_IMAGE_DIMENSIONS   = [994, 496]

  has_many_attached :images do |image|
    image.variant :brochure_sm, resize_to_limit: SM_BROCHURE_IMAGE_DIMENSIONS
    image.variant :brochure_base, resize_to_limit: BASE_BROCHURE_IMAGE_DIMENSIONS
    image.variant :brochure_lg, resize_to_limit: LG_BROCHURE_IMAGE_DIMENSIONS
  end
  has_many_attached :files

  # Use HasMoneytaryAttributes to generate
  # helper methods
  monetary_attribute :naming_rights_cost

  pg_search_scope :search, against: %i[internal_id street_name city postal_code], using: {
    trigram: {
      threshold: 0.1
    }
  }

  # Building area = all areas (except land_area and hard_stand_yard_area)
  def building_area
    building_area_attributes
      .map { |attr| self.public_send(attr) }
      .compact_blank
      .reduce(0.0, :+)
  end

  def total_area
    [building_area, land_area, hard_stand_yard_area]
      .compact_blank
      .reduce(0.0, :+)
  end

  def short_address
    [unit_suite_shop, number_and_street, city].compact_blank.join(', ')
  end

  def full_address
    [unit_suite_shop, floor, number_and_street, city, postal_code, state, country].compact_blank.join(', ')
  end

  def type_label
    type.delete_suffix('Property')
  end

  def name_label
    try(:name) || 'No name'
  end

  def number_and_street
    [street_number, street_name].compact_blank.join(' ')
  end

  def city_and_state
    [city.try(:capitalize), state].compact_blank.join(', ')
  end

  # Needs to be overriden by child classes
  def usage_values
    %i[none]
  end

  def parking_spaces?
    parking_spaces.present? && parking_spaces.positive?
  end

  # Return PropertyRequirement for which this property
  # falls in
  def property_requirements
    RelatedPropertyRequirementsQuery.new(self).call || []
  end

  # Return all the Property.Agent Contacts who are looking
  # for this property
  def prospects
    agent.visible_contacts.where(id: property_requirements.pluck(:contact_id).uniq) if contract.present?
  end

  def website_link
    return nil if website_url.blank?

    website_url
  end

  def image_already_attached?(filename)
    images.each do |image|
      return true if image.blob.filename == filename
    end
    false
  end

  def contract?
    Contract.exists?(property_id: id)
  end

  private

  def generate_internal_id
    update_column(:internal_id, "#{account.company_name[0..2].upcase}-#{id}") if internal_id.blank?
  end

  def calculate_building_area
    self.calculated_building_area = building_area
  end
end

# == Schema Information
#
# Table name: properties
#
#  agent_id                                :bigint           not null
#  archived_at                             :datetime
#  brochure_description_deprecated         :text
#  building                                :string
#  calculated_building_area                :decimal(, )
#  city                                    :string
#  clear_span_columns                      :string
#  country                                 :string
#  crane                                   :string
#  created_at                              :datetime         not null
#  disability_access                       :string
#  domain_com_au_listed                    :boolean          default(FALSE)
#  domain_com_au_listing_id                :string
#  domain_com_au_process_id                :string
#  entrances_roller_doors_container_access :string
#  estate                                  :string
#  fit_out_deprecated                      :text
#  floor                                   :string
#  floor_area                              :decimal(10, 2)
#  floor_level                             :string
#  furniture_deprecated                    :text
#  grabline                                :string
#  hard_stand_yard_area                    :decimal(10, 2)
#  hard_stand_yard_description             :string
#  headline                                :string
#  id                                      :bigint           not null, primary key
#  internal_id                             :string
#  keywords                                :string
#  land_area                               :decimal(10, 2)
#  land_area_description                   :string
#  lifts_escalators_travelators            :string
#  local_council                           :string
#  lot_number                              :string
#  max_clearance_height                    :decimal(10, 2)
#  min_clearance_height                    :decimal(10, 2)
#  name                                    :string
#  naming_rights                           :string
#  naming_rights_cost_cents                :integer
#  notes_deprecated                        :text
#  office_area                             :decimal(10, 2)
#  parking_comments                        :string
#  parking_spaces                          :integer
#  postal_code                             :string
#  production_area                         :decimal(10, 2)
#  rating                                  :string
#  rea_listed                              :boolean          default(FALSE)
#  rea_listing_id                          :string
#  showroom_area                           :decimal(10, 2)
#  state                                   :string
#  storage_area                            :decimal(10, 2)
#  street_name                             :string
#  street_number                           :string
#  trading_area                            :decimal(10, 2)
#  type                                    :string
#  unique_space_deprecated                 :string
#  unit_suite_shop                         :string
#  updated_at                              :datetime         not null
#  usages                                  :string           default([]), is an Array
#  warehouse_area                          :decimal(10, 2)
#  website_description_deprecated          :text
#  website_url                             :string
#  zoning                                  :string
#
# Indexes
#
#  index_properties_on_agent_id     (agent_id)
#  index_properties_on_internal_id  (internal_id)
#  index_properties_on_type         (type)
#  index_properties_on_usages       (usages) USING gin
#
