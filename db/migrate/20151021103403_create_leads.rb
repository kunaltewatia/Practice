class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :uuid
      t.string :type
      t.string :mobile_number

      t.timestamps null: false
    end
  end
end
