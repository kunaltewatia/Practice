# Auth Token To Mobile User
class AuthTokenToMobileUser < ActiveRecord::Migration
  def change
    add_column :mobile_users, :auth_token, :string
  end
end
