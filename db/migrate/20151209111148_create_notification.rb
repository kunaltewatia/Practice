# Notification
class CreateNotification < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :body
      t.text :payload
      t.references :mobile_user, index: true, foreign_key: true
      t.references :subscription, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
