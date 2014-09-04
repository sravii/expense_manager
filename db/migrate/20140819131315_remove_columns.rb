class RemoveColumns < ActiveRecord::Migration
  def up
  	remove_column :expenses, :date
  end

  def down
  end
end
