require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the Sample1Helper. For example:
#
# describe Sample1Helper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do
	describe "human datetime" do
		it "returns the date and time in a friendly format" do
			date = Time.parse("10/02/2014 4:30pm")
			helper.human_datetime(date).should eq(date.strftime("%B #{date.day.ordinalize}, %Y at %I:%M %p"))
		end
	end
	describe "human date" do
		it "returns the date in a friendly format" do
			date = Time.parse("10/02/2014")
			human_date(date).should eq(date.strftime("%B #{date.day.ordinalize}, %Y"))
			human_date(nil).should eq('')
		end
	end
end