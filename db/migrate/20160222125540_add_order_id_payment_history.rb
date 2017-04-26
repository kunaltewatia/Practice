class AddOrderIdPaymentHistory < ActiveRecord::Migration
  def change
    add_column :payment_histories, :order_id, :string
  end
end
