class AddOrderTable < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :user_name
      t.references :product, index: true, foreign_key: true
      t.references :plan, index: true, foreign_key: true
      t.references :locality, index: true, foreign_key: true
      t.string :unit
      t.string :price
      t.string :address
      t.string :order_id
      t.text :response
      t.string :status

      t.timestamps null: false
    end
  end
end
