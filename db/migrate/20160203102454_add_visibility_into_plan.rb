class AddVisibilityIntoPlan < ActiveRecord::Migration
  def change
  	add_column :plans, :is_visible, :boolean, default: false, nil: :false
  end
end
