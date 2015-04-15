json.array!(@withdraw_records) do |withdraw_record|
  json.extract! withdraw_record, :id, :bank_name, :bank_card, :amount
  json.url withdraw_record_url(withdraw_record, format: :json)
end
