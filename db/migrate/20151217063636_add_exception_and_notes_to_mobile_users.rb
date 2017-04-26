class AddExceptionAndNotesToMobileUsers < ActiveRecord::Migration
  def change
    add_column :mobile_users, :exceptions, :string
    add_column :mobile_users, :notes, :text
  end
end
