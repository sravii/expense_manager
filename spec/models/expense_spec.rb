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
  pending "add some examples to (or delete) #{__FILE__}"
end
