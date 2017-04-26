# LocalityServices migration
class CreateLocalityServices < ActiveRecord::Migration
  def change
    create_table :locality_services do |t|
      t.references :service, index: true, foreign_key: true
      t.references :locality, index: true, foreign_key: true
      t.boolean :is_active, default: true, null: false

      t.timestamps null: false
    end
  end
end
