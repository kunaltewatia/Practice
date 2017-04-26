class AddReferralToDelivery < ActiveRecord::Migration
  def change
    add_reference :deliveries, :referral, index: true, foreign_key: true
  end
end
