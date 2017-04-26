# CreateComplaints
class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.references :mobile_user
      t.references :user
      t.references :complaint_category
      t.text :complaint_text
      t.text :admin_comment
      t.boolean :status, default: true, nil: :false

      t.timestamps null: false
    end
  end
end
