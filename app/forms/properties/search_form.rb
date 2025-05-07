module Properties
  class SearchForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    # Searchable attributes
    attr_accessor :usages, :classifications

    attribute :street_name,     :string,  default: nil
    attribute :city,            :string,  default: nil
    attribute :postal_code,     :string,  default: nil
    attribute :country,         :string,  default: Current.country.presence
    attribute :state,           :string,  default: Current.state.presence
    attribute :district,        :string,  default: nil
    attribute :for_sale,        :boolean, default: nil
    attribute :for_lease,       :boolean, default: nil
    attribute :sale_price_min,  :float,   default: nil
    attribute :sale_price_max,  :float,   default: nil
    attribute :lease_price_min, :float,   default: nil
    attribute :lease_price_max, :float,   default: nil
    attribute :total_area_min,  :float,   default: nil
    attribute :total_area_max,  :float,   default: nil

    def initialize(params = {})
      @params = params
      super params
    end

    def self.model_name
      ActiveModel::Name.new(self, nil, 'PropertySearchForm')
    end

    def default_contract_types
      %w[for_lease for_sale]
    end

    def default_classifications
      %w[commercial industrial residential retail]
    end

    def default_usages
      %w[acreage apartment development farming flat hotel house warehouse land land_development medical offices retail_store retirement rural service_apartment showrooms studio townhouse unit villa other]
    end
  end
end
