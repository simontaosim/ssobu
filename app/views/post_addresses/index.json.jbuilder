json.array!(@post_addresses) do |post_address|
  json.extract! post_address, :id, :planet_id, :country_id, :province_id, :city_id, :area_id
  json.url post_address_url(post_address, format: :json)
end
