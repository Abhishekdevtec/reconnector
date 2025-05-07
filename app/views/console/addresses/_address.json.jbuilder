json.extract! address, :id, :addressable_type, :addressable_id, :category, :line_1, :line_2, :line_3, :city, :postal_code, :state, :country_id, :created_at, :updated_at
json.url address_url(address, format: :json)
