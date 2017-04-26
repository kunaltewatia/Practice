class AddIsActiveToCity < ActiveRecord::Migration
  def change
    add_column :cities, :is_active, :boolean, default: true, nil: :false
  end
end
