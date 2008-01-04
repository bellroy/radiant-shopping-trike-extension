require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < Test::Unit::TestCase
  test_helper :pages, :render
  
  def setup
    @page = StorePage.new
  end
end
