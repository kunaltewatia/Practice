# Group Localities Serializer
class GroupLocalitiesSerializer < ActiveModel::Serializer
  attributes :id, :name, :area_id, :is_active

  has_many :societies, serializer: GroupSocietiesSerializer
end
