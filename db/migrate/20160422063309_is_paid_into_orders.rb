class IsPaidIntoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_paid, :boolean, default: false, nil: :false
  end
end
