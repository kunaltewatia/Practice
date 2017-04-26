# AddOsColumnToAuthentication
class AddOsColumnToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :os, :string
  end
end
