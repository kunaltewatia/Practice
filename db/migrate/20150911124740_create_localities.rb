# Create locality
class CreateLocalities < ActiveRecord::Migration
  def change
    create_table :localities do |t|
      t.string :name
      t.references :area, index: true, foreign_key: true
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
