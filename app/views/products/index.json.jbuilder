json.array!(@products) do |product|
  json.extract! product, :id, :service_id, :name, :origin, :description,
                :is_active
  json.url product_url(product, format: :json)
end
