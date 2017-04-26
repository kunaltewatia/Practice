# add type into notifications
class AddTypeNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :_type, :string
  end
end
