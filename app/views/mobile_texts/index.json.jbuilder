json.array!(@mobile_texts) do |mobile_text|
  json.extract! mobile_text, :id, :username, :scode, :mobile, :content, :extcode, :sendtime, :msgid, :msgtype, :signtag, :temid
  json.url mobile_text_url(mobile_text, format: :json)
end
