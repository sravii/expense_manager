# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  amount      :float
#  category    :string(255)
#  date        :datetime
#  description :string(255)
#  reminder_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Expense < ActiveRecord::Base
	
  attr_accessible :amount, :category, :description, :reminder_id, :created_at

  validates :user_id, presence: true

  after_create :update_pay_dates

  validates :category, presence: { message: "Please choose a category" }
  validates :amount, presence: { message: "Please enter an amount" }, numericality: { greater_than: 0, message: "Please enter a positive value for amount" }
  validates :created_at, presence: { message: "Please select a date and time" }

  belongs_to :user
  belongs_to :reminder

  default_scope order('created_at DESC')
  # scope :food, where(category: 1)

  scope :currentMonth, where("created_at >= ?", Time.zone.now.beginning_of_month)

  CATEGORY = {
           1 => 'Food',
           2 => 'Electricity Bill',
           3 => 'Phone Bill',
           4 => 'Health',
           5 => 'Transportaion',
           6 => 'Leisure',
           7 => 'Others' }
  
  # Callbacks for create
  # Check if the reminder has been associated.
  # If so update the reminder, with last_pay_date.

  def update_pay_dates
    reminder.update_attributes(:last_pay_date => created_at, :next_pay_date => reminder.next_pay_date + (reminder.frequency).months ) unless reminder.nil?
  end
  
end
