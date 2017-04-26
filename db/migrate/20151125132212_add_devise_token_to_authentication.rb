# devise token into authentications
class AddDeviseTokenToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :devise_token, :string
  end
end
