class AddFruitNameToComplaint < ActiveRecord::Migration
  def change
    add_column :complaints, :fruit_name, :string
  end
end
