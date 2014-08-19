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
	
  attr_accessible :amount, :category, :date, :description, :reminder_id

  validates :user_id, presence: true

  after_create :has_reminder_been_associated


  validates :category, presence: true
  validates :date, presence: true
  validates :amount, presence: true

  belongs_to :user
  belongs_to :reminder

  default_scope order: 'expenses.date DESC'

  CATEGORY = [['-----------', 0],
              ['Electricity Bill',1],
              ['Phone Bill', 2],
              ['Health', 3],
              ['Transportaion',4],
              ['Leisure', 5],
              ['Food', 6],
              ['Others', 7]]

  CATEGORY_BY_VALUE = Hash[*CATEGORY.map { |i| [i[1], i[0]] }.flatten]

  # Callbacks for create
  # Check if the reminder has been associated.
  # If so update the reminder, with last_pay_date.

  def has_reminder_been_associated
    unless reminder.nil?
      case reminder.frequency
        when 0
          # Do nothing
        when 1
          reminder.next_pay_date = reminder.next_pay_date + 1.months
        when 4
          reminder.next_pay_date = reminder.next_pay_date + 4.months
        when 12
          reminder.next_pay_date = reminder.next_pay_date + 12.months
      end
      reminder.update_attributes(:last_pay_date => date, :next_pay_date => reminder.next_pay_date )
    end
  end
end
