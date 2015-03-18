json.array!(@users) do |user|
  json.extract! user, :id, :email, :third_party, :encrypt_password
  json.url user_url(user, format: :json)
end
