class AddOrderIdIntoCompliant < ActiveRecord::Migration
  def change
    change_table :complaints do |t|
      t.references :order, index: true, foreign_key: true
    end
  end
end
