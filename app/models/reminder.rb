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
  attr_accessible :alert_off, :alert_theshold, :boolean, :category, :description, :frequency, :last_pay_date, :next_pay_date
  belongs_to :user

  has_many :expenses, dependent: :destroy

  validates :user_id, presence: true

  validates :category, presence: true
  validates :alert_theshold, presence: true
  validates :frequency, presence: true
  validates :next_pay_date, presence: true

  default_scope order: 'reminders.next_pay_date'

  FREQ = [['--------', -1],
          ['Once', 0],
          ['Monthly', 1],
          ['Quaterly', 4],
          ['Yearly', 12]]

  CATEGORY = [['-----------', 0],
              ['Electricity Bill',1],
              ['Phone Bill', 2],
              ['Health', 3],
              ['Transportaion',4],
              ['Leisure', 5],
              ['Food', 6],
              ['Others', 7]]

  CATEGORY_BY_VALUE = Hash[*CATEGORY.map { |i| [i[1], i[0]] }.flatten]
  FREQ_BY_VALUE = Hash[*FREQ.map { |i| [i[1], i[0]] }.flatten]

end
