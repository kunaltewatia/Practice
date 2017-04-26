class AddProductIdIntoPlans < ActiveRecord::Migration
  def change
    change_table :plans do |t|
      t.references :product, index: true, foreign_key: true
    end
  end
end
