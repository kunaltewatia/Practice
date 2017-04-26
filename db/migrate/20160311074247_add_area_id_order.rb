class AddAreaIdOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :area, index: true, foreign_key: true
  end
end
