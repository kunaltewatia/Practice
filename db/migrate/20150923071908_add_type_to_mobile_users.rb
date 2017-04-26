class AddTypeToMobileUsers < ActiveRecord::Migration
  def change
    add_column :mobile_users, :type, :string
  end
end
