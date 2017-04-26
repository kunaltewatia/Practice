# AddOtpSecretKeyToSubscription
class AddOtpSecretKeyToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :otp_secret_key, :string
  end
end
