json.array!(@bank_cards) do |bank_card|
  json.extract! bank_card, :id, :name, :code, :ower_name
  json.url bank_card_url(bank_card, format: :json)
end
