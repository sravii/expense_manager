class RemindersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_reminder, :except => [:new, :index, :create]

  def new
  	@reminder = current_user.reminders.new	
  	render layout: false
  end

  def index
  	@reminders = current_user.reminders
  end

  def create
  	# @reminder = Reminder.new(params[:reminder])
  	# @reminder.user_id = current_user.id
  	@reminder = current_user.reminders.build(params[:reminder])
    @reminder.alert_off = true
    if @reminder.save
      redirect_to reminders_path
  	else
  	# 	puts "*" * 100
			# puts @reminder.errors.inspect
			# puts "*" * 100
		end
  end

  def edit
  	# @reminder = current_user.reminders.find(params[:id])
    # p @reminder.inspect
  	render layout: false
  end

  def update
    # @reminder = current_user.reminders.find(params[:id])
    if @reminder.update_attributes(params[:reminder])
      redirect_to reminders_path
    else
    end
  end

  def destroy
    # @reminder = current_user.reminders.find(params[:id])
    @reminder.destroy
    redirect_to reminders_url
  end

  def paid
    # @reminder = current_user.reminders.find(params[:id])
    @expense = current_user.expenses.new
    @expense.reminder_id = @reminder.id
    @expense.category = @reminder.category
    render layout: false
  end

  private

  def load_reminder
    @reminder = current_user.reminders.find(params[:id])
  end 

end
