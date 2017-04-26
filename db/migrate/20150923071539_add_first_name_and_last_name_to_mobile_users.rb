class AddFirstNameAndLastNameToMobileUsers < ActiveRecord::Migration
  def change
    add_column :mobile_users, :first_name, :string
    add_column :mobile_users, :last_name, :string
  end
end
