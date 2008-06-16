require File.dirname(__FILE__) + '/../test_helper'

class StorePageTest < Test::Unit::TestCase
  test_helper :render, :pages

  def setup
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    
    Product.delete_all
  end

  def test_find_by_url_with_store
    @page = Page.new(:title => "Home", :slug => "/")
    Product.expects(:find_by_code).with("a").returns(Product.new(:code => "A"))
    store = StorePage.new(:title => "Store", :slug => "store", :status_id => 100, :parent_id => @page.id)
    store.stubs(:parent).returns(@page)
    @page.children.expects(:find_by_slug).returns(store)
    
    assert_equal store, @page.find_by_url('/store/a/')
  end

  def test_store_product_each_tag
    @page = StorePage.new
    create_test_products 3
    
    assert_renders 'test-product-0!test-product-1!test-product-2!', '<r:shopping:product:each><r:shopping:product:code />!</r:shopping:product:each>', '/store/'
  end
  
  def test_product_addtocart_tag
    @page = StorePage.new
    create_test_products
    
    assert_render_match /<form/i, '<r:shopping:product:each><r:shopping:product:addtocart /></r:shopping:product:each>', '/store/'
  end
  
  def test_product_expresspurchase_tag
    @page = StorePage.new
    create_test_products
    
    assert_render_match /<form/i, '<r:shopping:product:each><r:shopping:product:expresspurchase /></r:shopping:product:each>', '/store/'
  end
  
  def test_store_product_each_tag_only_specific_products
    @page = StorePage.new
    create_test_products 3
    
    assert_renders 'test-product-0!test-product-2!', '<r:shopping:product:each only="test-product-0 test-product-2"><r:shopping:product:code />!</r:shopping:product:each>', '/store/'
  end
  
  def test_store_product_each_tag_only_one_product_and_one_bad_code
    @page = StorePage.new
    create_test_products 3
    
    assert_renders 'test-product-2!', '<r:shopping:product:each only="test-product-8 test-product-2"><r:shopping:product:code />!</r:shopping:product:each>', '/store/'
  end

  def test_store_product_attribute_tags
    @page = StorePage.new
    create_test_products
    
    assert_renders 'test-product-0', '<r:shopping:product:each><r:shopping:product:code /></r:shopping:product:each>', '/store/'
    assert_renders 'This test product is number 0.', '<r:shopping:product:each><r:shopping:product:description /></r:shopping:product:each>', '/store/'
    assert_renders '0.99', '<r:shopping:product:each><r:shopping:product:price /></r:shopping:product:each>', '/store/'
    assert_renders '0.89', '<r:shopping:product:each><r:shopping:product:price quantity="10"/></r:shopping:product:each>', '/store/'
  end
  
  def test_store_product_link_tag
    @page = StorePage.new
    create_test_products
    
    assert_renders '<a href="//test-product-0"></a>', '<r:shopping:product:each><r:shopping:product:link /></r:shopping:product:each>', '/store/'
  end
  
  private
    def create_test_products( number = 1 )
      number.times do |prod_id|
        prod = Product.new(:code => "test-product-#{ prod_id }",
                           :description => "This test product is number #{ prod_id }.",
                           :product_category => 'bCisive')
        prod.product_prices << ProductPrice.new(:min_quantity => 0, :price => 0.99 + prod_id)
        prod.product_prices << ProductPrice.new(:min_quantity => 5, :price => 0.89 + prod_id)
        prod.save!
      end
    end
end

