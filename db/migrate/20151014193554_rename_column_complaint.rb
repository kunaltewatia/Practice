class RenameColumnComplaint < ActiveRecord::Migration
  def change
    rename_column :complaints, :status, :is_resolved
  end
end
