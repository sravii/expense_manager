class ExpensesController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_expense, :except => [:new, :index, :create]
   

  def new
  	@expense = current_user.expenses.new
  	render layout: false
  end

  def index
  	@expenses = current_user.expenses
  end

  def create
  	@expense = current_user.expenses.build(params[:expense])
   	if @expense.save
      redirect_to expenses_path
  	else
      #
  	end
  end

  def edit
  	# @expense = current_user.expenses.find(params[:id])
  	render layout: false
  end

  def update
  	# @expense = current_user.expenses.find(params[:id])
    if @expense.update_attributes(params[:expense])
      redirect_to expenses_path
    else
    end
  end

  def destroy
    # @expense = current_user.expenses.find(params[:id])
    @expense.destroy
    redirect_to expenses_url
  end

  private

  def load_expense
    @expense = current_user.expenses.find(params[:id])
  end 

end
