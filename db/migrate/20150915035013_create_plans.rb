# create plans
class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :pack, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :old_price
      t.decimal :price
      t.integer :days
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
