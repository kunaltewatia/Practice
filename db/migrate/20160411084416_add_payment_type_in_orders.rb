class AddPaymentTypeInOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_type, :string, index: true
  end
end
