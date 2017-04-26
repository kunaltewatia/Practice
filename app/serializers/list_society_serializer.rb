# ListSociety
class ListSocietySerializer < ActiveModel::Serializer
  attributes :id, :name, :locality_id, :latitude, :longlatitude, :is_active
end
