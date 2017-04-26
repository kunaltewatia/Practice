class ChangeOldPriceFormatInPlans < ActiveRecord::Migration
  def change
    change_column :plans, :old_price, :decimal
  end
end
