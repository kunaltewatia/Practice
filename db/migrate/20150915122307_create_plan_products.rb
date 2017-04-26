class CreatePlanProducts < ActiveRecord::Migration
  def change
    create_table :plan_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :package, index: true, foreign_key: true
      t.references :measurement, index: true, foreign_key: true
      t.date :date
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
