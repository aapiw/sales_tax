require 'spec_helper'

#SWITCH ONE TO RUN THE OTHER CASE
def test_case type
	"#{type}1.csv"
	# "#{type}2.csv"
	# "#{type}3.csv"
end

describe "Report object" do

 	before :each do
    @report = Report.new test_case("input")
	end

 describe "#new" do

 	context "with no parameters" do
 		it	"has no items" do
 			report = Report.new
 			expect(report.items.count).to be < 1
 		end
 	end

 	context "with params csv" do
 		it "has some items" do
 			expect(@report.items.count).to be > 1
 		end
 	end

 end

	it "accepts new item" do
		@report.add_item( Item.new(1,"new imported box of chocolates,10.00", 15) )
		expect(@report.items.last).to be_instance_of(Item)
	end

	it "saves the report" do
	  items = @report.items.map { |item| item.product }
	  @report.save(test_case("output"))
	  report2 = Report.new test_case("input")
	  items2 = report2.items.map { |item| item.product }
	  expect(items).to eq(items2)
	end

end
