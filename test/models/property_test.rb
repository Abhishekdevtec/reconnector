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
require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:country)
    # should validate_length_of(:usages).is_at_most(3)
    should belong_to(:agent)
  end

  test 'should create internal_id when saving a new property' do
    agent = agents(:bill)
    property = agent.commercial_properties.new(country: 'Australia')
    assert_nil property.internal_id

    property.save
    sleep(1.second) # Give the after_create_commit callback some time
    property.reload
    assert_not_nil property.internal_id
  end

  test 'should update calculated_building_area when saving' do
    agent = agents(:bill)
    property = agent.commercial_properties.new(country: 'Australia')
    assert_nil property.calculated_building_area

    property.save
    assert_equal 0.0, property.calculated_building_area

    property.office_area = 111.5
    property.storage_area = 222.5
    assert_equal 0.0, property.calculated_building_area

    property.save
    property.reload
    assert_equal 334.00, property.calculated_building_area
  end

  test 'should allow nil domain_com_au_listing_id' do
    property = properties(:already_listed) # Assuming you have fixture data
    property.domain_com_au_listing_id = nil
    assert property.valid?
  end

  test 'should enforce uniqueness of domain_com_au_listing_id' do
    existing_property = properties(:already_listed) # Assuming you have fixture data
    property = Property.new(domain_com_au_listing_id: existing_property.domain_com_au_listing_id)
    refute property.valid?
    assert_includes property.errors[:domain_com_au_listing_id], 'has already been taken'
  end

  test 'should allow nil domain_com_au_process_id' do
    property = properties(:already_listed) # Assuming you have fixture data
    property.domain_com_au_process_id = nil
    assert property.valid?
  end

  test 'should enforce uniqueness of domain_com_au_process_id' do
    existing_property = properties(:already_listed) # Assuming you have fixture data
    property = Property.new(domain_com_au_process_id: existing_property.domain_com_au_process_id)
    refute property.valid?
    assert_includes property.errors[:domain_com_au_process_id], 'has already been taken'
  end

  test 'property should not be shared by default' do
    property = Property.new
    assert_not property.share
    assert_not property.shared?
  end
end
