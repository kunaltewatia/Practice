# ChangeDateFormatOfPaymentHistory
class ChangeDateFormatOfPaymentHistory < ActiveRecord::Migration
  def change
    change_column :payment_histories, :starts_date, :date
    change_column :payment_histories, :ends_date, :date
  end
end
