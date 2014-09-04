require 'spec_helper'

describe ExpensesController do
	before do
	  @user = FactoryGirl.create(:user)
	 	sign_in @user
	end

	describe "GET #new" do
	  it "assigns a new Expense to @expense" do
	    get :new
	    controller.instance_variable_get("@item").should be_a_new(Expense)
	  end
	  it "should render the new template" do
	  	get :new
	  	controller.should render_template("new")
		end
	end

	describe "GET #index" do
		before {
			@expenses = FactoryGirl.create_list(:expense, 3, :user => @user)
			}

		it "populates an array of expenses" do
			get :index
			controller.instance_variable_get("@items").should =~ @expenses 
		end 

		it "renders the :index view" do 
			get :index 
			response.should render_template :index 
		end 
	end

	describe "POST create" do
	  context "with valid attributes" do
	    it "creates a new expense" do
	      expect{
	        post :create, expense: FactoryGirl.attributes_for(:expense)
	      }.to change(Expense,:count).by(1)
	    end 
	    it "redirects to expense#index" do
	      post :create, expense: FactoryGirl.attributes_for(:expense)
	      response.should redirect_to expenses_url
	    end
	  end 
	  context "with invalid attributes" do
	    it "does not save the new expense" do
	      expect { 
	      	 post :create, expense: @user.expenses.build(amount: -100.00)
	      }.to_not change(Expense,:count)
	    end 
	    it "must contain errors" do
	      post :create, expense: @user.expenses.build(amount: -100.00) 
	      controller.instance_variable_get("@item").errors.should_not be_empty
	    end 
	  end 
	end

	describe "GET #edit" do
		before :each do
			@expense = FactoryGirl.create(:expense, :user => @user)
		end
	  it "should render the edit template" do
	  	get :edit, id: @expense
	  	controller.should render_template("edit")
		end
	end

	describe 'PUT update' do
		before :each do
			@expense = FactoryGirl.create(:expense, :user => @user)
		end
		context "valid attributes" do
			it "located the requested @expense" do
				put :update, id: @expense, expense: FactoryGirl.attributes_for(:expense)
				controller.instance_variable_get("@item").should eq @expense
			end 
			it "changes @expense's attributes" do
				put :update, id: @expense, expense: FactoryGirl.attributes_for(:expense, category: 3, amount: 400.00)
				@expense.reload
				@expense.category.should eq(3)
				@expense.amount.should eq(400.00)
			end 
			it "redirects to expense#index" do
				put :update, id: @expense, expense: FactoryGirl.attributes_for(:expense)
				response.should redirect_to expenses_url
			end 
		end 
		context "invalid attributes" do
			it "locates the requested @expense" do
				put :update, id: @expense, expense: FactoryGirl.attributes_for(:expense)
				controller.instance_variable_get("@item").should eq @expense
			end 
			it "does not change @expense's attributes" do
				put :update, id: @expense, expense: @user.expenses.build(category: 3, amount: nil)
				@expense.reload
				@expense.category.should_not eq(3)
				@expense.amount.should eq(100.00)
			end 
			# it "must contain errors" do
	  #     put :update, id: @expense, expense: @user.expenses.build(category: 3, amount: nil)
	  #     controller.instance_variable_get("@item").errors.should_not be_empty
	  #   end  
		end
	end

	describe 'DELETE destroy' do
		before :each do
			@expense = FactoryGirl.create(:expense, :user => @user)
		end
		it "deletes the expense" do
			expect {
				delete :destroy, id: @expense
			}.to change(Expense,:count).by(-1)
		end 
		it "redirects to expense#index" do
			delete :destroy, id: @expense
			response.should redirect_to expenses_url
		end 
	end
end