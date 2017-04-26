# ChangeDateFormatOfSubscription
class ChangeDateFormatOfSubscription < ActiveRecord::Migration
  def change
    change_column :subscriptions, :start_at, :date
    change_column :subscriptions, :ends_at, :date
  end
end
