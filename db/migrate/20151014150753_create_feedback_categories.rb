class CreateFeedbackCategories < ActiveRecord::Migration
  def change
    create_table :feedback_categories do |t|
      t.string :name
      t.text :description
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
