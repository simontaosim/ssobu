json.array!(@product_intros) do |product_intro|
  json.extract! product_intro, :id
  json.url product_intro_url(product_intro, format: :json)
end
