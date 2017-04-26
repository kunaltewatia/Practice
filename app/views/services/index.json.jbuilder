json.array!(@services) do |service|
  json.extract! service, :id, :name, :description, :parent_id, :is_active
  json.url service_url(service, format: :json)
end
