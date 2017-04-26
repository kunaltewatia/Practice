class AddIsSmsIsNotificationsInCustomNotifications < ActiveRecord::Migration
  def change
    add_column :custom_notifications, :is_sms, :boolean, default: false, nil: :false
    add_column :custom_notifications, :is_notification, :boolean, default: false, nil: :false
  end
end
