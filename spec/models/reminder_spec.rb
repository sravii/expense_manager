# == Schema Information
#
# Table name: reminders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  description    :string(255)
#  alert_theshold :integer
#  frequency      :string(255)
#  category       :string(255)
#  alert_off      :boolean
#  next_pay_date  :date
#  last_pay_date  :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Reminder do
  let(:user) { FactoryGirl.create(:user) }
  before { @reminder = user.reminders.build(category: 1, frequency: 1, alert_threshold: 4, next_pay_date: Date.today ) }

  subject { @reminder }

  it { should respond_to(:category) }
  it { should respond_to(:frequency) }
  it { should respond_to(:alert_threshold) }
  it { should respond_to(:last_pay_date) }
  it { should respond_to(:next_pay_date) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
      expect do
        Reminder.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @reminder.user_id = nil }
    it { should_not be_valid }
  end

  describe "when category is not present" do
    before { @reminder.category = nil }
    it { should_not be_valid }
  end

  describe "when frequency is not present" do
    before { @reminder.frequency = nil }
    it { should_not be_valid }
  end

  describe "when alert threshold is not present" do
    before { @reminder.alert_threshold = nil }
    it { should_not be_valid }
  end

  describe "when alert threshold is negative" do
    before { @reminder.alert_threshold = -2 }
    it { should_not be_valid }
  end

  describe "when next pay date is not present" do
    before { @reminder.next_pay_date = nil }
    it { should_not be_valid }
  end

end