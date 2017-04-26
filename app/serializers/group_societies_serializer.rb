# Group Societies Serializer
class GroupSocietiesSerializer < ActiveModel::Serializer
  attributes :id, :name, :locality_id, :latitude, :longlatitude, :is_active

  has_many :wings, serializer: GroupWingsSerializer
end
