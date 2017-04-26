# CustomerSubscriptionSerializer
class CustomerSubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :ends_at, :payment_status, :payment_type,
             :created_at, :updated_at, :paused_dates
  has_one :plan, serializer: CustomerPlanSerializer
  has_many :payment_histories, serializer: SubsPaymentHistoriesSerializer

  def paused_dates
    object.subscription_pauses.pause_dates(object.id).pluck(:date)
  end
end
