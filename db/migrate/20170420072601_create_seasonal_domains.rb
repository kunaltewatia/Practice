class CreateSeasonalDomains < ActiveRecord::Migration
  def change
    create_table :seasonal_domains do |t|
      t.string :name, index: true
      t.string :subdomain
      t.timestamps null: false
    end
  end
end

