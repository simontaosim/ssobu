json.array!(@product_images) do |product_image|
  json.extract! product_image, :id, :name, :is_cover, :url
  json.url product_image_url(product_image, format: :json)
end
