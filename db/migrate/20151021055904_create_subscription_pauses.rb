# CreateSubscriptionPauses
class CreateSubscriptionPauses < ActiveRecord::Migration
  def change
    create_table :subscription_pauses do |t|
      t.references :subscription, index: true, foreign_key: true
      t.references :mobile_user, index: true, foreign_key: true
      t.datetime :date

      t.timestamps null: false
    end
  end
end
