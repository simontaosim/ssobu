json.array!(@product_lines) do |product_line|
  json.extract! product_line, :id, :quantity
  json.url product_line_url(product_line, format: :json)
end
