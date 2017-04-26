# Configuration
class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :name
      t.boolean :is_active, default: true, nil: :true
      t.timestamps null: false
    end
  end
end
