# CreateMobileUsers
class CreateMobileUsers < ActiveRecord::Migration
  def change
    create_table :mobile_users do |t|
      t.string :mobile_number
      t.string :uuid
      t.boolean :is_verified, default: false
      t.timestamps null: false
    end
  end
end
