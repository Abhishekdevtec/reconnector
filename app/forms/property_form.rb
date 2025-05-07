class PropertyForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # Property attributes
  attribute :type,                                    :string,  default: nil
  attribute :agent_id,                                :big_integer
  attribute :internal_id,                             :string,  default: nil
  attribute :usages,                                  :string,  default: nil
  attribute :unique_space_deprecated,                 :string,  default: nil
  attribute :floor_level,                             :string,  default: nil
  attribute :name,                                    :string,  default: nil
  attribute :building,                                :string,  default: nil
  attribute :naming_rights,                           :string,  default: nil
  attribute :naming_rights_cost,                      :string,  default: nil
  attribute :estate,                                  :string,  default: nil
  attribute :unit_suite_shop,                         :string,  default: nil
  attribute :floor,                                   :string,  default: nil
  attribute :street_number,                           :string,  default: nil
  attribute :street_name,                             :string,  default: nil
  attribute :state,                                   :string,  default: nil
  attribute :city,                                    :string,  default: nil
  attribute :postal_code,                             :string,  default: nil
  attribute :country,                                 :string,  default: nil
  attribute :office_area,                             :decimal, default: 0
  attribute :warehouse_area,                          :decimal, default: 0
  attribute :showroom_area,                           :decimal, default: 0
  attribute :storage_area,                            :decimal, default: 0
  attribute :production_area,                         :decimal, default: 0
  attribute :trading_area,                            :decimal, default: 0
  attribute :land_area,                               :decimal, default: 0
  attribute :hard_stand_yard_area,                    :decimal, default: 0
  attribute :floor_area,                              :decimal, default: 0
  attribute :headline,                                :string,  default: nil
  attribute :grabline,                                :string,  default: nil
  attribute :keywords,                                :string,  default: nil
  attribute :brochure_description,                    :string,  default: nil
  attribute :website_description,                     :string,  default: nil
  attribute :parking_spaces,                          :integer, default: 0
  attribute :parking_comments,                        :string,  default: nil
  attribute :fit_out,                                 :string,  default: nil
  attribute :furniture,                               :string,  default: nil
  attribute :lifts_escalators_travelators,            :string,  default: nil
  attribute :min_clearance_height,                    :decimal, default: 0
  attribute :max_clearance_height,                    :decimal, default: 0
  attribute :clear_span_columns,                      :string,  default: nil
  attribute :crane,                                   :string,  default: nil
  attribute :entrances_roller_doors_container_access, :string,  default: nil
  attribute :zoning,                                  :string,  default: nil
  attribute :disability_access,                       :string,  default: nil
  attribute :rating,                                  :string,  default: nil
  attribute :website_url,                             :string,  default: nil

  delegate :id, :persisted?, :model_name, :to_param, :images, :files, to: :@property, allow_nil: true

  def initialize(params = {})
    @property = create_new_record
    @params = params
    super params
  end

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      save_property
      save_photos
      save_files
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  # Returns an array of usage values by
  # Property type (Commercial, Industrial, ...)
  def usage_values
    @property.usage_values
  end

  private

  def save_property
  end

  def save_photos
  end

  def save_files
  end
end
