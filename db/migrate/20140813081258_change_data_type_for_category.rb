class ChangeDataTypeForCategory < ActiveRecord::Migration
  def change
  	change_column :reminders, :category, :integer
  	change_column :expenses, :category, :integer
  end
end
