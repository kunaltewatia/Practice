# DefaultValueToSubacription
class DefaultValueToSubacription < ActiveRecord::Migration
  def change
    change_column :subscriptions, :is_paused, :boolean,
                  default: false, null: :false
  end
end
