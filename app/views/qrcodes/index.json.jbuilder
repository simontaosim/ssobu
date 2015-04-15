json.array!(@qrcodes) do |qrcode|
  json.extract! qrcode, :id, :user_id, :product_id, :url
  json.url qrcode_url(qrcode, format: :json)
end
