# RenameColumnOfComplaint
class RenameColumnOfComplaint < ActiveRecord::Migration
  def change
    rename_column :complaints, :complaint_text, :text
  end
end
