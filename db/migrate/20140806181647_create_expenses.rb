class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.float :amount
      t.string :category
      t.datetime :date
      t.string :description
      t.integer :reminder_id

      t.timestamps
    end
  end
  add_index :expenses, [:user_id, :created_at]
  add_index :expenses, [:reminder_id, :created_at]
end
