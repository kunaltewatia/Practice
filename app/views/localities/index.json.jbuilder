json.array!(@localities) do |locality|
  json.extract! locality, :id, :name, :area_id, :is_active
  json.url locality_url(locality, format: :json)
end
