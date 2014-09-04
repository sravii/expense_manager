require 'spec_helper'

describe UserPagesController do
	before { 
	  	@user = FactoryGirl.create(:user)
	  	sign_in @user
	  }

	describe "GET #overview" do
		before {
			@expenses = FactoryGirl.create_list(:expense, 3, :user => @user)
			}
	  it "should render the overview template" do
	  	get :overview
	  	controller.should render_template("overview")
	  end
	  it "assigns a current month's expenses to sum" do
	    get :overview
	    controller.instance_variable_get("@sum").should eq(Expense.currentMonth.sum(:amount))
	  end
	end
end