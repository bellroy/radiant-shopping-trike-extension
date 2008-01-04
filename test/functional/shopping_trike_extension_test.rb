require File.dirname(__FILE__) + '/../test_helper'

class ShoppingTrikeExtensionTest < Test::Unit::TestCase
  test_helper :pages, :render
  
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
  
end
