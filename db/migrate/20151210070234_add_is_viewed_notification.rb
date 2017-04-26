# add is_viewed to notification
class AddIsViewedNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :is_viewed, :boolean, default: false, nil: :false
  end
end
