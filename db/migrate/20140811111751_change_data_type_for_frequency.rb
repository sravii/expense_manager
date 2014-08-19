class ChangeDataTypeForFrequency < ActiveRecord::Migration
  # def up
  # end

  # def down
  # end

  def change
  	change_column :reminders, :frequency, :integer
  end
end
