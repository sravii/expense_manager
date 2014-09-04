class RenameColumns < ActiveRecord::Migration
  def change
	rename_column :reminders, :alert_off, :alert_on
  end
end
