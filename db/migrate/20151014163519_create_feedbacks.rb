class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :mobile_user, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :text
      t.text :admin_comment
      t.boolean :is_resolved
      t.references :feedback_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
