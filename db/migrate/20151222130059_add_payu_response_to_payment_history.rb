# Add Payu Response to payment History
class AddPayuResponseToPaymentHistory < ActiveRecord::Migration
  def change
    add_column :payment_histories, :response, :text
    add_column :payment_histories, :mode, :string
    add_column :payment_histories, :status, :string
  end
end
