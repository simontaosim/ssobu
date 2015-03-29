json.array!(@province_states) do |province_state|
  json.extract! province_state, :id, :name
  json.url province_state_url(province_state, format: :json)
end
