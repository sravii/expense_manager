class ExpensesController < ApplicationController

  include ControllerMethods
  
  def class_name
    "expenses"
  end

  def redirect_path
    expenses_path
  end

  def model_name
    :expense
  end

end
