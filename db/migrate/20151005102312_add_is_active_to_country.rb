# AddIsActiveToCountry
class AddIsActiveToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :is_active, :boolean, default: true, nil: :false
  end
end
