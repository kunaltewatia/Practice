# Rename column of start and end date for pause
class RenameStartDateAndEndDateOnSubcription < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :start_date, :pause_start_date
    rename_column :subscriptions, :end_date, :pause_end_date
  end
end
