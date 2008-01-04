require File.dirname(__FILE__) + '/../test_helper'

class StorePageTest < Test::Unit::TestCase
  test_helper :pages

  def test_find_by_url_with_store
    @page = Page.new(:title => "Home", :slug = "/")
    Product.expects(:find_by_code).with("a").returns(Product.new(:code => "A"))
    store = StorePage.new(:title => "Store", :slug => "store", :status_id => 100)
    @page.children << store

    assert_equal store, @page.find_by_url('/store/a/')
  end

end

