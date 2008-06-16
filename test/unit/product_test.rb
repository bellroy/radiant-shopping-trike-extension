require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../app/models/product'

class ProductTest < Test::Unit::TestCase
  test_helper :pages, :render
  
  def setup
    @page = StorePage.new
  end

  def test_that_products_are_defined
    assert defined?(Product)
  end
  
  def test_that_a_product_with_no_code_is_invalid
    product = product_with_code( nil )
    assert ! product.save
  end
  
  # TO DO
#   def test_that_a_product_with_no_price_is_invalid
#     product = product_with_price( nil )
#     assert ! product.save
#   end
#   
#   def test_that_a_product_with_a_negative_price_is_invalid
#     product = product_with_price( -0.99 )
#     assert ! product.save
#   end
#   
#   def test_that_a_product_with_a_zero_price_is_invalid
#     product = product_with_price( 0.00 )
#     assert ! product.save
#   end
  
  def test_that_a_product_with_a_resrved_name_is_invalid
    %w{checkout eula cart}.each do |reserved_code|
      # create a product with a resrved code and assert that it doesn't save
      product = product_with_code( reserved_code )
      assert ! product.save
    end
  end
  
  private 
    def product_with_code( code )
      product = Product.new
      product.code = code
      product.description = "A test product!"
      product
    end
    
end
