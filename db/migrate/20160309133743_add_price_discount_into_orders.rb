class AddPriceDiscountIntoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount, :string
  end
end
