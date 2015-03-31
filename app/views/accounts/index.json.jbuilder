json.array!(@accounts) do |account|
  json.extract! account, :id, :total, :currency, :other, :plus, :massage
  json.url account_url(account, format: :json)
end
