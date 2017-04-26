# Group Area Serializer
class GroupAreaSerializer < ActiveModel::Serializer
  attributes :id, :name, :city_id, :is_active

  has_many :localities, serializer: GroupLocalitiesSerializer
end
