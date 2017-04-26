# Create Areas
class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.references :city, index: true, foreign_key: true
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
