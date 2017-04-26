# remove _type for Lead Table
class RemoveTypeFromLeadTable < ActiveRecord::Migration
  def change
    remove_column :leads, :type
  end
end
