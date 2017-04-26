# Add IsPaid To Payment Histories
class AddIsPaidToPaymentHistories < ActiveRecord::Migration
  def change
    add_column :payment_histories, :is_paid, :boolean, default: true, nil: :false
  end
end
