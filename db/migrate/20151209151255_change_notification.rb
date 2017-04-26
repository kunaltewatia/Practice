# change notification
class ChangeNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :payload, :text
  end
end
