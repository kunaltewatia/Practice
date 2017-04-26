# Create Society
class CreateSocieties < ActiveRecord::Migration
  def change
    create_table :societies do |t|
      t.string :name
      t.references :locality, index: true, foreign_key: true
      t.string :latitude
      t.string :longlatitude
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
