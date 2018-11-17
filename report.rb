require 'csv'    
require 'pry'
require_relative 'item'

class Report
	attr_accessor :items
	
	def initialize file_name = false
		@items = []
		if file_name
			csv_contents = CSV.read(file_name)
			csv_contents.shift
			csv_contents.each do |row|
			  @items << Item.new(row[0].to_i, row[1], row[2].to_f)
			end
		end

	end

	def count_sales_taxes
		@items.map{|e|e.tax}.reduce(:+)
	end

	def count_total
		@items.map{|e|e.price_with_tax}.reduce(:+).round(2)
	end

	def add_item item
		@items << item
	end

	def save name = "output1.csv"
		CSV.open(name, 'w') do |csv|
			csv << ["Quantity", "Product", "Price"]
		  @items.each do |item|
				csv << [item.quantity, item.product, item.price_with_tax]
		  end
				csv << ["Sales Taxes", "", '%.2f' % count_sales_taxes]
				csv << ["Total", "", count_total]
		end
	end
end