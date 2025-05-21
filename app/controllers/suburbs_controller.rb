class SuburbsController < ApplicationController
  def autocomplete
    query = params[:query].to_s.strip
    distinct_names = City.where("name ILIKE ?", "%#{query}%").distinct.pluck(:name).first(10)

    render json: distinct_names.map { |name| { name: name } }
  end

  def postal_codes
    city_name = params[:name]
    codes = City.where(name: city_name).distinct.pluck(:postal_code)
    render json: codes
  end
end
