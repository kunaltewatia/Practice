# Serializer for CustomerPlan
class CustomerPlanSerializer < ActiveModel::Serializer
  attributes :id, :name, :old_price, :price, :days, :description
  has_one :pack, serializer: CustomerPlanPackSerializer
end
