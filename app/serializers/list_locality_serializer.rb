# Serializer for list localities for specific areas
class ListLocalitySerializer < ActiveModel::Serializer
  attributes :id, :name, :area_id, :is_active
end
