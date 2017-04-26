# serializer for Area
class ListAreaSerializer < ActiveModel::Serializer
  attributes :id, :name, :city_id, :is_active
end
