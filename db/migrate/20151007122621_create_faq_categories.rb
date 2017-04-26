# migration file for faq categories
class CreateFaqCategories < ActiveRecord::Migration
  def change
    create_table :faq_categories do |t|
      t.string :name
      t.text :description
      t.references :service, index: true, foreign_key: true
      t.boolean :is_active, default: false, nil: :false

      t.timestamps null: false
    end
  end
end
