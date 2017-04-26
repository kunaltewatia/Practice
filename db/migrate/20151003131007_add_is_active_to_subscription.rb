# AddIsActiveToSubscription
class AddIsActiveToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :is_active, :boolean, default: true, nil: :false
  end
end
