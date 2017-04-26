class CustomerwisePausedSerializer < ActiveModel::Serializer
  attributes :id, :date, :pack, :plan, :subscription_id

  def pack
    object.subscription.plan.pack.name
  end

  def plan
    object.subscription.plan.name
  end
end
