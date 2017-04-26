class AddFlatNoToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :flat_no, :string
  end
end
