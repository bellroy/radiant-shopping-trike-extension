require File.dirname(__FILE__) + '/../test_helper'

# Re-raise errors caught by the controller.
CartController.class_eval { def rescue_action(e) raise e end }

class CartControllerTest < Test::Unit::TestCase

  def setup
    @controller = CartController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    
    ProductPrice.delete_all
    Product.delete_all

    # create two test products
    @product_a = Product.new
    @product_a.code = "PROD-A"
    @product_a.description = "Test product A."
    @product_a.product_category = "bCisive"
    @product_a.product_prices << ProductPrice.new(:min_quantity => 0, :price => 1.00)
    @product_a.product_prices << ProductPrice.new(:min_quantity => 10, :price => 0.90)
    @product_a.save!
    
    @product_b = Product.new
    @product_b.code = "PROD-B"
    @product_b.description = "Test product B."
    @product_b.product_category = "bCisive"
    @product_b.product_prices << ProductPrice.new(:min_quantity => 0, :price => 2.00)
    @product_b.product_prices << ProductPrice.new(:min_quantity => 10, :price => 1.80)
    @product_b.save!
    
    # since most cart controller actions redirect we need a referer
    @request.env["HTTP_REFERER"] = "http://example.com/home"
  end

  def test_that_invalid_cart_additions_or_updates_add_nothing  
    post :add_or_update_in_cart
    assert session[:cart].nil?
    
    post :add_or_update_in_cart, {:id => 100000, :quantity => 5}
    assert session[:cart].nil?
  end

  def test_that_a_cart_is_created
    insert_into_cart( @product_a )
    assert !session[:cart].nil?
  end
  
  def test_that_a_product_can_be_inserted_and_updated_in_a_cart
    # insert single unit of product A
    insert_into_cart( @product_a )
    assert session[:cart].items.length == 1
    cart_item = session[:cart].items.first
    assert cart_item.product.code == "PROD-A"
    assert cart_item.quantity == 1
    
    
    # update cart with another one of product A
    insert_into_cart( @product_a )
    assert session[:cart].items.length == 1
    cart_item = session[:cart].items.first
    assert cart_item.product.code == "PROD-A"
    assert cart_item.quantity == 2
  end
  
  def test_that_an_item_can_be_removed_from_the_cart
    # insert a single unit of product A and B
    insert_into_cart( @product_a )
    insert_into_cart( @product_b )
    
    # remove product A from the cart and test that onlt product B remains
    post :process_cart_change, {:submit_type => "remove", :remove_submit => {@product_a.id => ''}}
    assert session[:cart].items.length == 1
    assert session[:cart].items.first.product.id == @product_b.id
  end
  
  def test_that_a_cart_can_be_emptied
    # insert a single unit of product A and B
    insert_into_cart( @product_a )
    insert_into_cart( @product_b )
    
    # empty the cart
    post :process_cart_change, {:submit_type => "empty"}
    assert session[:cart].items.length == 0
  end
  
  def test_that_cart_contents_can_be_updated
    # insert single units of products A and B
    insert_into_cart( @product_a )
    insert_into_cart( @product_b )
    
    # update both quantities
    post :process_cart_change, {:submit_type => "update", "update" => { @product_a.id => 2, @product_b.id => 4}}
    cart = session[:cart]
    assert cart.quantity_of_product( @product_a ) == 2
    assert cart.quantity_of_product( @product_b ) == 4
  end
  
  def test_that_a_negative_quantity_removes_an_item_from_the_cart
    # insert a single unit of product A
    insert_into_cart( @product_a )
    
    # insert -2 units of product A
    insert_into_cart( @product_a, -2 )
    assert session[:cart].items.length == 0
  end
  
  def test_that_a_zero_quantity_removes_an_item_from_the_cart
    # insert a single unit of product A
    insert_into_cart( @product_a )
    
    # insert -1 of product A
    insert_into_cart( @product_a, -1 )
    assert session[:cart].items.length == 0
  end
  
  def test_that_a_cart_add_with_a_quantity_of_zero_does_not_change_the_cart
    # insert single unit of product A
    insert_into_cart( @product_a )

    # insert 0 units of product A
    insert_into_cart( @product_a, 0 )
    
    assert session[:cart].items.first.quantity == 1
  end
  
  def test_that_removing_an_item_not_actually_in_the_cart_does_nothing
    # insert a single unit of product A and B
    insert_into_cart( @product_a )
    
    # remove product A from the cart and test that onlt product B remains
    post :process_cart_change, {:submit_type => "remove", :remove_submit => {@product_b.id => ''}}
    assert session[:cart].items.length == 1
  end
  
  def test_that_cart_total_is_calculated_correctly_for_first_price_break_with_and_without_gst
    # insert five units of products A and B
    insert_into_cart( @product_a, 5 )
    insert_into_cart( @product_b, 5 )
    
    # a = 1, b = 2
    # 5a + 5b = 15
    assert_in_delta 16.50, session[:cart].total, 0.0001
    session[:cart].gst_charged = false
    assert_in_delta 15.00, session[:cart].total, 0.0001
    session[:cart].gst_charged = true
    assert_in_delta 16.50, session[:cart].total, 0.0001
  end
  
  def test_that_cart_total_is_calculated_correctly_for_second_price_break_with_and_without_gst
    # insert five units of products A and B
    insert_into_cart( @product_a, 10 )
    insert_into_cart( @product_b, 10 )
    
    # a = 0.90, b = 1.80
    # 10a + 10b = 9.00 + 18.00 = 27.00
    assert_in_delta 29.70, session[:cart].total, 0.0001
    session[:cart].gst_charged = false
    assert_in_delta 27.00, session[:cart].total, 0.0001
    session[:cart].gst_charged = true
    assert_in_delta 29.70, session[:cart].total, 0.0001
  end
  
  def test_savings_for_product_quantity_returns_price
    get :savings_for_product_quantity, {:id => @product_a.id, :quantity => 1}
    assert_response :success
    assert_equal '0.00', @response.body
    
    get :savings_for_product_quantity, {:id => @product_b.id, :quantity => 20}
    assert_response :success
    #1.80 * 20 = 36.00 which is 4.00 less then 2.00 * 20
    assert_equal '4.00', @response.body
  end
  
  def test_savings_for_product_quantity_returns_na_for_invalid_values
    get :savings_for_product_quantity, {:id => '987654321', :quantity => 1}
    assert_response :success
    assert_equal 'N/A', @response.body

    get :savings_for_product_quantity, {:id => @product_a.id, :quantity => -1}
    assert_response :success
    assert_equal 'N/A', @response.body
  end
  
  def test_price_for_product_quantity_returns_price
    get :price_for_product_quantity, {:id => @product_a.id, :quantity => 1}
    assert_response :success
    assert_equal '1.00', @response.body

    get :price_for_product_quantity, {:id => @product_b.id, :quantity => 20}
    assert_response :success
    assert_equal '1.80', @response.body
  end
  
  def test_price_for_product_quantity_returns_na_for_invalid_values
    get :price_for_product_quantity, {:id => '987654321', :quantity => 1}
    assert_equal 'N/A', @response.body
    get :price_for_product_quantity, {:id => @product_a.id, :quantity => -1}
    assert_equal 'N/A', @response.body
  end
  
  private
    def insert_into_cart( product, quantity = 1)
      post :add_or_update_in_cart, {:id => product.id, :quantity => quantity}
    end
end
