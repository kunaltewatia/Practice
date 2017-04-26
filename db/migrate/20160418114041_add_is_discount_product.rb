class AddIsDiscountProduct < ActiveRecord::Migration
  def change
    add_column :products, :is_discounted, :boolean, default: true, nil: :false
  end
end
