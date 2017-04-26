class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.references :mobile_user, index: true, foreign_key: true
      t.string :contact
      t.boolean :is_converted, default: false, null: false

      t.timestamps null: false
    end
  end
end
