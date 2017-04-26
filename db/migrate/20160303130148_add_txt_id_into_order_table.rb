class AddTxtIdIntoOrderTable < ActiveRecord::Migration
  def change
    add_column :orders, :txt_id, :string
  end
end
