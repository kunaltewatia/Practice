# CreateSubscriptions
class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :plan, index: true, foreign_key: true
      t.references :mobile_user, index: true, foreign_key: true
      t.datetime :start_at
      t.datetime :ends_at

      t.timestamps null: false
    end
  end
end
