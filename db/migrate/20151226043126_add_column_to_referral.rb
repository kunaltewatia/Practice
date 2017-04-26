class AddColumnToReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :referred_id, :integer
  end
end
