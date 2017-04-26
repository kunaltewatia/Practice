class AddPaymentTypeToPaymentHistory < ActiveRecord::Migration
  def change
    add_column :payment_histories, :payment_type, :string
  end
end
