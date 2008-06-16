require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/models/product_price'

class ProductPriceTest < Test::Unit::TestCase
  test_helper :pages, :render
  
  def setup
    @page = StorePage.new
  end

  def test_that_product_prices_are_defined
    assert defined?(ProductPrice)
  end
  
  def test_that_a_product_price_with_no_price_is_invalid
    product_price = product_price_with_price( nil )
    assert ! product_price.save
  end
  
  def test_that_a_product_price_with_a_negative_price_is_invalid
    product_price = product_price_with_price( -0.99 )
    assert ! product_price.save
  end
  
  def test_that_a_product_price_with_a_zero_price_is_invalid
    product_price = product_price_with_price( 0.00 )
    assert ! product_price.save
  end
  
  private 
    
    def product_price_with_price( price )
      product_price = ProductPrice.new
      product_price.min_quantity = 0
      product_price.price = price
      product_price
    end
end
