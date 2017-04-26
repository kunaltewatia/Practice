# Create wings
class CreateWings < ActiveRecord::Migration
  def change
    create_table :wings do |t|
      t.string :name
      t.references :society, index: true, foreign_key: true
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
