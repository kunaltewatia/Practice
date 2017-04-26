# PlanPackIndexSerializer
class PlanPackIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :old_price, :price, :days, :pack_id, :is_active
end
