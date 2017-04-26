# add subscription_id into deliveries
class AddSubscriptionToDelivery < ActiveRecord::Migration
  def change
    add_reference :deliveries, :subscription, index: true
  end
end
