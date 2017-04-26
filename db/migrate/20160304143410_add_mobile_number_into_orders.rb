class AddMobileNumberIntoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :mobile_number, :string
  end
end
