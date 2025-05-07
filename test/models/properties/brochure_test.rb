# == Schema Information
#
# Table name: properties
#
#  id                                      :bigint           not null, primary key
#  type                                    :string
#  agent_id                                :bigint           not null
#  internal_id                             :string
#  usages                                  :string           default([]), is an Array
#  unique_space                            :string
#  floor_level                             :string
#  name                                    :string
#  building                                :string
#  naming_rights                           :string
#  naming_rights_cost_cents                :integer
#  estate                                  :string
#  suite                                   :string
#  floor                                   :string
#  street_number                           :string
#  street_name                             :string
#  state                                   :string
#  city                                    :string
#  postal_code                             :string
#  country                                 :string
#  local_council                           :string
#  office_area                             :decimal(10, 2)
#  warehouse_area                          :decimal(10, 2)
#  showroom_area                           :decimal(10, 2)
#  storage_area                            :decimal(10, 2)
#  production_area                         :decimal(10, 2)
#  trading_area                            :decimal(10, 2)
#  floor_area                              :decimal(10, 2)
#  land_area                               :decimal(10, 2)
#  hard_stand_yard_area                    :decimal(10, 2)
#  land_area_description                   :string
#  hard_stand_yard_description             :string
#  headline                                :string
#  grabline                                :string
#  keywords                                :string
#  description                             :text
#  features                                :text
#  parking_spaces                          :integer
#  parking_comments                        :string
#  fit_out                                 :text
#  furniture                               :text
#  lifts_escalators_travelators            :string
#  min_clearance_height                    :decimal(10, 2)
#  max_clearance_height                    :decimal(10, 2)
#  clear_span_columns                      :string
#  lot_number                              :string
#  crane                                   :string
#  entrances_roller_doors_container_access :string
#  zoning                                  :string
#  disability_access                       :string
#  rating                                  :string
#  notes                                   :text
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#  rea_listing_id                          :string
#  domain_com_au_listing_id                :string
#  domain_com_au_listed                    :boolean          default(FALSE)
#  rea_listed                              :boolean          default(FALSE)
#  domain_com_au_process_id                :string
#  website_url                             :string
#  calculated_building_area                :decimal(, )
#  archived_at                             :datetime
#

require "test_helper"

module Properties
  class BrochureTest < ActiveSupport::TestCase
    test 'should export brochure' do
      property = properties(:with_contract)
      export_folder = Rails.root.join('tmp', 'test_files')
      FileUtils.mkdir_p(Rails.root.join('tmp', 'test_files'))
      exported_pdf_filename = export_folder.join(property.brochure.filename)
      assert !File.exist?(exported_pdf_filename)

      property.brochure.export_to(export_folder)
      assert File.exist?(exported_pdf_filename)

      # Cleanup
      FileUtils.remove_dir(Rails.root.join('tmp', 'test_files'))
    end
  end
end
