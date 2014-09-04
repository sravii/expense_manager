require 'spec_helper'

describe RemindersController do
	before { 
	  	@user = FactoryGirl.create(:user)
	  	sign_in @user
	  }

	describe "GET #new" do
	  it "assigns a new Reminder to @reminder" do
	    get :new
	    controller.instance_variable_get("@item").should be_a_new(Reminder)
	  end
	  it "should render the new template" do
	  	get :new
	  	controller.should render_template("new")
		end
	end

	describe "GET #index" do
		before {
			@reminders = FactoryGirl.create_list(:reminder, 3, :user => @user)
			}

		it "populates an array of reminders" do
			get :index
			controller.instance_variable_get("@items").should =~ @reminders 
		end 

		it "renders the :index view" do 
			get :index 
			response.should render_template :index 
		end 
	end

	describe "POST create" do
	  context "with valid attributes" do
	    it "creates a new reminder" do
	      expect{
	        post :create, reminder: FactoryGirl.attributes_for(:reminder)
	      }.to change(Reminder,:count).by(1)
	    end 
	    it "redirects to reminder#index" do
	      post :create, reminder: FactoryGirl.attributes_for(:reminder)
	      response.should redirect_to reminders_url
	    end
	  end 
	  context "with invalid attributes" do
	    it "does not save the new reminder" do
	      expect { 
	      	 post :create, reminder: @user.reminders.build(category: nil)
	      }.to_not change(Reminder,:count)
	    end 
	    it "must contain errors" do
	      post :create, reminder: @user.reminders.build(category: nil) 
	      controller.instance_variable_get("@item").errors.should_not be_empty
	    end 
	  end 
	end

	describe "GET #edit" do
		before :each do
			@reminder = FactoryGirl.create(:reminder, :user => @user)
		end
	  it "should render the edit template" do
	  	get :edit, id: @reminder
	  	controller.should render_template("edit")
		end
	end

	describe 'PUT update' do
		before :each do
			@reminder = FactoryGirl.create(:reminder, :user => @user)
		end
		context "valid attributes" do
			it "located the requested @reminder" do
				put :update, id: @reminder, reminder: FactoryGirl.attributes_for(:reminder)
				controller.instance_variable_get("@item").should eq @reminder
			end 
			it "changes @reminder's attributes" do
				put :update, id: @reminder, reminder: FactoryGirl.attributes_for(:reminder, category: 3, frequency: 3)
				@reminder.reload
				@reminder.category.should eq(3)
				@reminder.frequency.should eq(3)
			end 
			it "redirects to reminder#index" do
				put :update, id: @reminder, reminder: FactoryGirl.attributes_for(:reminder)
				response.should redirect_to reminders_url
			end 
		end 
		context "invalid attributes" do
			it "locates the requested @reminder" do
				put :update, id: @reminder, reminder: FactoryGirl.attributes_for(:reminder)
				controller.instance_variable_get("@item").should eq @reminder
			end 
			it "does not change @reminder's attributes" do
				put :update, id: @reminder, reminder: @user.reminders.build(category: 3, frequency: nil)
				@reminder.reload
				@reminder.category.should_not eq(3)
				@reminder.frequency.should eq(1)
			end 
			# it "must contain errors" do
	  #     put :update, id: @reminder, reminder: @user.reminders.build(category: 3, amount: nil)
	  #     controller.instance_variable_get("@item").errors.should_not be_empty
	  #   end  
		end
	end

	describe "GET #paid" do
	  before :each do
		@reminder = FactoryGirl.create(:reminder, :user => @user)
	  end
	  it "assigns a new Expense to @expense" do
	    get :paid, id: @reminder
	    controller.instance_variable_get("@expense").should be_a_new(Expense)
	  end
	  it "should render the paid template" do
	  	get :paid, id: @reminder
	  	controller.should render_template("paid")
	  end
	end


	describe 'DELETE destroy' do
		before :each do
			@reminder = FactoryGirl.create(:reminder, :user => @user)
		end
		it "deletes the reminder" do
			expect {
				delete :destroy, id: @reminder
			}.to change(Reminder,:count).by(-1)
		end 
		it "redirects to reminder#index" do
			delete :destroy, id: @reminder
			response.should redirect_to reminders_url
		end 
	end
end