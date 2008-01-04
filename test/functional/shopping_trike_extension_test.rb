require File.dirname(__FILE__) + '/../test_helper'

class ShoppingTrikeExtensionTest < Test::Unit::TestCase
  
  def test_initialization
    assert_equal(File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'shopping_trike'),
                 ShoppingTrikeExtension.root)
    assert_equal 'Shopping Trike', ShoppingTrikeExtension.extension_name
  end
  
  def test_should_define_pages
    [StorePage, ProductPage].each do |page|
      assert defined?(page)
    end
  end

  def test_store_products_each_tag
    @page = StoreProductPage.new
    
    assert_renders 'A B C ', '<r:store:products:each><r:code /> </r:store:products:each>', '/store/A/'
    assert_renders 'A B C ', '<r:store:products:each><r:code /> </r:store:products:each>', '/store/A'
  end
  
end
