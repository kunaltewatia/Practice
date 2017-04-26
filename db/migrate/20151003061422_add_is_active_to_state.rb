class AddIsActiveToState < ActiveRecord::Migration
  def change
    add_column :states, :is_active, :boolean, default: true, nil: :false
  end
end
