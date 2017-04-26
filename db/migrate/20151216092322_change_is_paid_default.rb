# changes
class ChangeIsPaidDefault < ActiveRecord::Migration
  def change
    change_column :payment_histories, :is_paid, :boolean, default: false, nil: :false
  end
end
