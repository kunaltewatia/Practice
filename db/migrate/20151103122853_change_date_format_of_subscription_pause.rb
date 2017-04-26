# ChangeDateFormatOfSubscriptionPause
class ChangeDateFormatOfSubscriptionPause < ActiveRecord::Migration
  def change
    change_column :subscription_pauses, :date, :date
  end
end
