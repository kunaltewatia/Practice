# Create Services
class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
