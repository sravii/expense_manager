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

class Reminder < ActiveRecord::Base
  attr_accessible :alert_threshold, :category, :description, :frequency, :last_pay_date, :next_pay_date
  belongs_to :user

  has_many :expenses

  validates :user_id, presence: true

  validates :category, presence: { message: "Please choose a category" }
  validates :alert_threshold, presence: { message: "Please enter a value for threshold" }, numericality: { greater_than: 0, message: "Please enter a positive value for threshold" }
  validates :frequency, presence: { message: "Please choose a frequency" }
  validates :next_pay_date, presence: { message: "Please choose the next pay date" }

  FREQ = {
          0 => 'Once',
          1 => 'Monthly',
          4 => 'Quaterly',
         12 =>'Yearly' }

  CATEGORY = {
               1 => 'Food',
               2 => 'Electricity Bill',
               3 => 'Phone Bill',
               4 => 'Health',
               5 => 'Transportaion',
               6 => 'Leisure',
               7 => 'Others' }

  default_scope order('next_pay_date')

  scope :alerts, where("next_pay_date < DATE( DATE_ADD(NOW(), INTERVAL `alert_threshold` DAY))")
  
end
