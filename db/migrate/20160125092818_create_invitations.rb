class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :mobile_number, index: true
      t.integer :count, default: 1, null: false
      t.timestamps null: false
    end
  end
end
