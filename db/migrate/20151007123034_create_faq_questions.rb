# migration file for faq Question
class CreateFaqQuestions < ActiveRecord::Migration
  def change
    create_table :faq_questions do |t|
      t.string :title
      t.text :description
      t.boolean :is_active, default: false, nil: :false
      t.references :faq_category, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
