json.array!(@roles) do |role|
  json.extract! role, :id, :name, :ability
  json.url role_url(role, format: :json)
end
