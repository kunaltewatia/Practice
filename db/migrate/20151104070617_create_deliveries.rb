# Create Table Delivery
class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references :mobile_user, index: true, foreign_key: true
      t.references :pack, index: true, foreign_key: true
      t.references :plan, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :area, index: true, foreign_key: true
      t.references :locality, index: true, foreign_key: true
      t.references :society, index: true, foreign_key: true
      t.references :wing, index: true, foreign_key: true
      t.references :complaint, index: true, foreign_key: true
      t.string :flat_no
      t.date :date, index: true

      t.timestamps null: false
    end
  end
end
