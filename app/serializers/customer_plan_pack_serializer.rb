# Serializer for Customer PlanPack
class CustomerPlanPackSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :service

  def service
    object.service.name
  end
end
