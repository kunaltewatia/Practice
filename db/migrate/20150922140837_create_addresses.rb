# CreateAddresses
class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :mobile_user, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :locality, index: true, foreign_key: true
      t.references :society, index: true, foreign_key: true
      t.references :wing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
