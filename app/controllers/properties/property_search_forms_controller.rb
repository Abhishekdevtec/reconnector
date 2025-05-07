# frozen_string_literal: true

module Properties
  class PropertySearchFormsController < ApplicationController
    before_action :authenticate_agent!
    before_action :set_nav_menu

    def new
      @property_search_form = Properties::SearchForm.new
    end

    def index
      @property_search_form = Properties::SearchForm.new(property_search_form_params)
      @properties = scoped_properties
    end

    private

    # TODO : Move this to a query object
    def scoped_properties
      results = @current_agent.properties.with_archived
      results = results.where(Property.arel_table[:type].in(property_search_form_params[:classifications].collect { |c| "#{c.capitalize}Property" })) if property_search_form_params[:classifications].present?
      results = results.where('lower(usages::text)::text[] && array[?]::text[]', property_search_form_params[:usages]) if property_search_form_params[:usages].present?
      results = results.where(Property.arel_table[:street_name].lower.matches("%#{property_search_form_params[:street_name].downcase}%")) if property_search_form_params[:street_name].present?
      results = results.where(postal_code: property_search_form_params[:postal_code]) if property_search_form_params[:postal_code].present?
      results = results.where(Property.arel_table[:city].lower.matches("%#{property_search_form_params[:city].downcase}%")) if property_search_form_params[:city].present?
      results = results.where(Property.arel_table[:state].lower.matches("%#{property_search_form_params[:state].downcase}%")) if property_search_form_params[:state].present?
      results = results.where(Property.arel_table[:country].lower.matches("%#{property_search_form_params[:country].downcase}%")) if property_search_form_params[:country].present?
      results = results.where('calculated_building_area >= ?', property_search_form_params[:total_area_min]) if property_search_form_params[:total_area_min].present?
      results = results.where('calculated_building_area <= ?', property_search_form_params[:total_area_max]) if property_search_form_params[:total_area_max].present?
      if property_search_form_params[:district].present?
        district = District.where(District.arel_table[:name].lower.matches("%#{property_search_form_params[:district].downcase}%")).first
      
        if district.present?
          if district.cities.any?
            city_names = district.cities.pluck(:name)
            postal_codes = district.cities.pluck(:postal_code)
      
            results = results.where(
              Property.arel_table[:city].in(city_names)
              .or(Property.arel_table[:postal_code].in(postal_codes))
            )
          else
            return Property.none
          end
        end
      end
      
      # Contract joins
      if property_search_form_params[:for_sale].present? && property_search_form_params[:for_lease].present?
        results = results.joins(:contract).where('contracts.for_sale')
        results = results.joins(:contract).where('contracts.for_lease')
      elsif property_search_form_params[:for_sale].present? && property_search_form_params[:for_lease].blank?
        results = results.joins(:contract).where('contracts.for_sale')
        results = results.joins(:contract).where.not('contracts.for_lease')
      elsif property_search_form_params[:for_lease].present? && property_search_form_params[:for_sale].blank?
        results = results.joins(:contract).where('contracts.for_lease')
        results = results.joins(:contract).where.not('contracts.for_sale')
      end
      results = results.joins(:contract).where('contracts.sale_actual_sale_price_cents >= ?', property_search_form_params[:sale_price_min].to_i * 100) if property_search_form_params[:sale_price_min].present?
      results = results.joins(:contract).where('contracts.sale_actual_sale_price_cents <= ?', property_search_form_params[:sale_price_max].to_i * 100) if property_search_form_params[:sale_price_max].present?
      if property_search_form_params[:lease_price_min].present?
        if property_search_form_params[:lease_price_min].to_f == 0 && property_search_form_params[:lease_price_max].present?
          lease_price_min_val = 1
          results = results.joins(:contract).where('contracts.lease_gross_rent * properties.calculated_building_area >= ?', lease_price_min_val )
        else
        results = results.joins(:contract).where('contracts.lease_gross_rent * properties.calculated_building_area >= ?', property_search_form_params[:lease_price_min])
        end
      end
      
      if property_search_form_params[:lease_price_max].present?
        lease_price_min_value = property_search_form_params[:lease_price_min].present? ? property_search_form_params[:lease_price_min] : 1
        results = results.joins(:contract).where('contracts.lease_gross_rent * properties.calculated_building_area >= ?', lease_price_min_value)
        results = results.joins(:contract).where('contracts.lease_gross_rent * properties.calculated_building_area <= ?', property_search_form_params[:lease_price_max])
      end
      results
    end

    def property_search_form_params
      params
        .require(:property_search_form)
        .permit(
          :street_name,
          :city,
          :postal_code,
          :country,
          :district,
          :state,
          :sale_price_min,
          :sale_price_max,
          :lease_price_min,
          :lease_price_max,
          :total_area_min,
          :total_area_max,
          :for_sale,
          :for_lease,
          usages: [],
          classifications: []
        )
    end

    def set_nav_menu
      set_nav_menu_option(:properties)
    end
  end
end
