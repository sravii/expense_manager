class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :reminders, :alert_theshold, :alert_threshold
  end
end
