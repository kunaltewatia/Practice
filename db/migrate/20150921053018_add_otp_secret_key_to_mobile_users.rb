class AddOtpSecretKeyToMobileUsers < ActiveRecord::Migration
  def change
    add_column :mobile_users, :otp_secret_key, :string
  end
end
