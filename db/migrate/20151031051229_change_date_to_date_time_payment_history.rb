class ChangeDateToDateTimePaymentHistory < ActiveRecord::Migration
  def change
    change_column :payment_histories, :starts_date, :datetime
    change_column :payment_histories, :ends_date, :datetime
  end
end
