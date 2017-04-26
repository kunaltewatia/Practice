json.array!(@areas) do |area|
  json.extract! area, :id, :name, :city_id, :is_active
  json.url area_url(area, format: :json)
end
