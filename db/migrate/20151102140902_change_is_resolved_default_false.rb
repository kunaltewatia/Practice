# change is resolved default false
class ChangeIsResolvedDefaultFalse < ActiveRecord::Migration
  def change
    change_column :complaints, :is_resolved, :boolean,
                  default: false, null: :false
    add_column :complaints, :is_extra_fruit, :boolean,
               default: false, null: :false
    add_column :complaints, :date, :date
    add_column :complaints, :delivery_date, :date

    add_index :complaints, :is_resolved
    add_index :complaints, [:is_extra_fruit, :delivery_date]
  end
end
