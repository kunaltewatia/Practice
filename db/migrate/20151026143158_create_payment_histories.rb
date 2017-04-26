# Payment Histories
class CreatePaymentHistories < ActiveRecord::Migration
  def change
    create_table :payment_histories do |t|
      t.references :subscription, index: true, foreign_key: true
      t.date :starts_date
      t.date :ends_date
      t.boolean :is_active
      t.string :subscription_type

      t.timestamps null: false
    end
  end
end
