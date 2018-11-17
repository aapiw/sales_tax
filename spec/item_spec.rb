require 'spec_helper'

describe Item do
	before :each do
	    @item = Item.new(1, "book", 12.49)
	end

	describe "#new" do
	   it "takes three parameters and returns an Item object" do
     	expect(@item).to be_instance_of(Item)
	   end
	end

	describe "#quantity" do
		it "returns the correct quantity" do
			expect(@item.quantity).to eq(1)
		end
	end
	
	describe "#product" do
	   it "returns the correct product" do
   		 expect(@item.product).to eq("book")
	   end
	end
	
	describe "#price" do
	   it "returns the correct price" do
   		 expect(@item.price).to eq(12.49)
	   end
	end

	describe "#tax" do
		context "without tax" do 
			it "returns 0" do
				price = @item.tax
				expect(price).to eq(0)
			end
		end

		context "with basic" do 
			it "returns the value of tax by 10%" do
				@item.product = "music cd"
				tax = @item.tax
				expect(tax).to eq(((@item.price*10)/100).ceil_to_zero_point_zero_five)
			end
		end

		context "with basic and imported item" do
			it "returns the value of the tax by 15%" do
				@item.product = "imported bottle of perfume"
				tax = @item.tax
				expect(tax).to eq(((@item.price*15)/100).ceil_to_zero_point_zero_five)
			end
		end

		context "with imported product" do
				it "returns the value of the tax by 5%" do
					@item.product = "box of imported chocolates"
					tax = @item.tax
					expect(tax).to eq(((@item.price*5)/100).ceil_to_zero_point_zero_five)
			end
		end
	end

	describe "#price_with_tax" do
		it "returns the price of the item plus its tax" do
			price_with_tax = @item.price_with_tax
			calc = ((@item.price + @item.tax)*@item.quantity).round(2)
			expect(price_with_tax).to eq(calc)
		end
	end

	describe "#basic_tax?" do
		it "returns the type of the tax" do
			expect(@item.basic_tax?).to eq(false)
		end
	end

	describe "#import_tax?" do
		it "returns the type of the tax" do
			expect(@item.import_tax?).to eq(false)
		end
	end

end

