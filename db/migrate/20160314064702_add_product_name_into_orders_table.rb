class AddProductNameIntoOrdersTable < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :product_name, index: true
      t.string :plan_unit, index: true
      t.string :plan_price, index: true
    end
  end
end
