class AddAreaIdToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :area, index: true, foreign_key: true
  end
end
