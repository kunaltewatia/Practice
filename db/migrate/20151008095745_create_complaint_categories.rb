# CreateComplaintCategories
class CreateComplaintCategories < ActiveRecord::Migration
  def change
    create_table :complaint_categories do |t|
      t.string :name
      t.text :description
      t.boolean :is_active, dafault: true, nil: :false
      t.timestamps null: false
    end
  end
end
