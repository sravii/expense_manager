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

