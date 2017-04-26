class AddPriceAndPackNameIntoPaymentHistories < ActiveRecord::Migration
  def change
    add_column :payment_histories, :price, :string
    add_column :payment_histories, :pack_name, :string
  end
end
