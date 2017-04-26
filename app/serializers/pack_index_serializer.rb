# PackIndexSerializer
class PackIndexSerializer < ActiveModel::Serializer
  attributes :id, :service_id, :name, :description, :is_active

  has_many :plans, each_serializer: PlanPackIndexSerializer

  def plans
  	object.plans.where(is_visible: true)
  end
end
