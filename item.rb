require 'pry'
require_relative 'float'

class Item
  attr_accessor :quantity, :product, :price
  
  def initialize(quantity, product, price)
    @quantity = quantity
    @product = product
    @price = price
  end

  def tax
    percent = 0
    percent = 10 if basic_tax?
    percent += 5 if import_tax?

    return (((@price*percent)/100)*quantity).ceil_to_zero_point_zero_five if percent != 0
    return percent
  end

  def price_with_tax
    if tax != 0
      ((@price + tax)*quantity).round(2)
    else
      (@price * quantity)
    end
  end

  def basic_tax?
    !(@product.include?"book" or
      @product.include?"chocolate" or
      @product.include?"chocolates" or
      @product.include?"pills")
  end

  def import_tax?
    imported = @product.include?"imported"
  end
end