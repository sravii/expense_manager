class RemindersController < ApplicationController
  
  include ControllerMethods
  
  def class_name
    "reminders"
  end

  def redirect_path
    reminders_path
  end

  def model_name
    :reminder
  end

  def paid
    @expense = current_user.expenses.new
    @expense.reminder_id = @item.id
    @expense.category = @item.category
    render layout: false
  end

end
