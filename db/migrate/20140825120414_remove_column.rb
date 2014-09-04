class RemoveColumn < ActiveRecord::Migration
  def up
  	remove_column :reminders, :alert_on
  end

  def down
  end
end
