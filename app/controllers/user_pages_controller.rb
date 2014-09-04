class UserPagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def overview
  	@sum = 0
  	@expenses = current_user.expenses.currentMonth
  	@expenses.each do |expense|
  		@sum += expense.amount
  	end
  	@alerts = current_user.reminders.alerts
  end

end
