class AddVisibilityIntoPacks < ActiveRecord::Migration
  def change
  	add_column :packs, :is_visible, :boolean, default: false, nil: :false
  end
end
