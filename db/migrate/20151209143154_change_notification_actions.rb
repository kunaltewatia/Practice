# change column name
class ChangeNotificationActions < ActiveRecord::Migration
  def change
    rename_column :notifications, :payload, :actions
  end
end
