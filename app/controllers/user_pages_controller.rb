class UserPagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def overview
  	@sum = 0
  	@expenses = current_user.expenses
  	@expenses.each do |expense|
  		@sum += expense.amount if expense.date.month == Date.today.month
  	end
  	@reminders = current_user.reminders
    @reminders.each do |reminder|
      reminder.alert_off = false if (reminder.next_pay_date - Date.today).to_i < reminder.alert_theshold
    end
  end

end
