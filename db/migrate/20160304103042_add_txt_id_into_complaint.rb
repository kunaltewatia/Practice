class AddTxtIdIntoComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :txt_id, :string
  end
end
