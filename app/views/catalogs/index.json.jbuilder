json.array!(@catalogs) do |catalog|
  json.extract! catalog, :id, :name, :fid
  json.url catalog_url(catalog, format: :json)
end
