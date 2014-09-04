class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.string :description
      t.integer :alert_threshold
      t.string :frequency
      t.string :category
      t.boolean :alert_off
      t.string :description
      t.date :next_pay_date
      t.date :last_pay_date

      t.timestamps
    end
  end
  add_index :reminders, [:user_id, :created_at]
end
