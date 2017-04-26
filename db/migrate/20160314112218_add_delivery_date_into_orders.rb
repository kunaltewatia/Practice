class AddDeliveryDateIntoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_date, :date, index: true
  end
end
