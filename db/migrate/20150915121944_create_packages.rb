class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.references :plan, index: true, foreign_key: true
      t.date :date

      t.timestamps null: false
    end
  end
end
