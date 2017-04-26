# CustomerDetailSerializer
class CustomerDetailSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :mobile_number,
             :subscriptions

  has_one :address, serializer: CustomerAddressSerializer
  has_many :subscriptions, serializer: CustomerSubscriptionSerializer

  def subscriptions
    object.subscriptions.active
  end
end
