require File.dirname(__FILE__) + '/../test_helper'

class ShoppingTrikeExtensionTest < Test::Unit::TestCase
  
  def test_initialization
    assert_equal(File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'shopping_trike'),
                 ShoppingTrikeExtension.root)
    assert_equal 'Shopping Trike', ShoppingTrikeExtension.extension_name
  end
  
end
