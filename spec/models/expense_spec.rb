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

require 'spec_helper'

describe Expense do
  let(:user) { FactoryGirl.create(:user) }
  before { @expense = user.expenses.build(category: 1, amount: 100.00, created_at: Time.now) }

  subject { @expense }

  it { should respond_to(:category) }
  it { should respond_to(:amount) }
  it { should respond_to(:created_at) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
      expect do
        Expense.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @expense.user_id = nil }
    it { should_not be_valid }
  end

  describe "when category is not present" do
    before { @expense.category = nil }
    it { should_not be_valid }
  end

  describe "when amount is not present" do
    before { @expense.amount = nil }
    it { should_not be_valid }
  end

  describe "when amount is negative" do
    before { @expense.amount = -1.2908 }
    it { should_not be_valid }
  end

  describe "when created_at is not present" do
    before { @expense.created_at = nil }
    it { should_not be_valid }
  end

end
