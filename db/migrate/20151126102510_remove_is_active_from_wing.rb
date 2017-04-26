# RemoveIsActiveFromWing
class RemoveIsActiveFromWing < ActiveRecord::Migration
  def change
    remove_column :wings, :is_active
  end
end
