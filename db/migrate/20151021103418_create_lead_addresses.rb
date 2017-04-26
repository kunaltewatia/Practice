class CreateLeadAddresses < ActiveRecord::Migration
  def change
    create_table :lead_addresses do |t|
      t.string :flat_no
      t.references :lead
      t.integer :country_id
      t.integer :state_id
      t.integer :city_id
      t.string :area
      t.string :locality
      t.string :society
      t.string :wing

      t.timestamps null: false
    end
  end
end
