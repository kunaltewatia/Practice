class CreateCustomNotifications < ActiveRecord::Migration
  def change
    create_table :custom_notifications do |t|
      t.string :message
      t.string :status
      t.timestamps null: false
    end
  end
end
