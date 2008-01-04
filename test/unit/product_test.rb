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
end
