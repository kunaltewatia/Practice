# AddColumnsToSubscription
class AddColumnsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :is_paused, :boolean
    add_column :subscriptions, :start_date, :date
    add_column :subscriptions, :end_date, :date
  end
end
