# Serializer for Product
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :origin, :description, :is_active
end
