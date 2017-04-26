# add is action notifications
class AddIsActionNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :is_actioned, :boolean,
               default: false, nil: :false
  end
end
