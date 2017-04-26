# MySubscriptionSerializer
class MySubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :active_subscription,
             :inactive_subscription
  has_many :active_subscription, serializer: CustomerSubscriptionSerializer
  has_many :inactive_subscription, serializer: CustomerSubscriptionSerializer

  def active_subscription
    object.subscriptions.active.where(plan_id: Plan.where(is_visible: true).pluck(:id))
  end

  def inactive_subscription
    object.subscriptions.inactive.where(plan_id: Plan.where(is_visible: true).pluck(:id))
  end
end
