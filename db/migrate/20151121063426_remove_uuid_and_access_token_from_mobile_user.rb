# Remove uuid and token from mobile user
class RemoveUuidAndAccessTokenFromMobileUser < ActiveRecord::Migration
  def change
    remove_column :mobile_users, :uuid
    remove_column :mobile_users, :auth_token
  end
end
