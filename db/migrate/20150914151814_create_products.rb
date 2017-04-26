# create products
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :service, index: true, foreign_key: true
      t.string :name
      t.string :origin
      t.text :description
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
