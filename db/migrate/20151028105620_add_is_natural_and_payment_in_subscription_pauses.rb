# Add Is Natural And Payment In SubscriptionPauses
class AddIsNaturalAndPaymentInSubscriptionPauses < ActiveRecord::Migration
  def change
    change_table :subscription_pauses do |t|
      t.references :payment_history, index: true, foreign_key: true
      t.boolean :is_natural, default: true, nil: :true
    end
  end
end
