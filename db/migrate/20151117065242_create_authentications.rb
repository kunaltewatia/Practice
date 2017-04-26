# authentication table
class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :mobile_user, index: true, foreign_key: true
      t.string :auth_token
      t.string :uuid

      t.timestamps null: false
    end
  end
end
