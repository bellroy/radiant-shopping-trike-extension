require File.dirname(__FILE__) + '/../test_helper'

# Re-raise errors caught by the controller.
CartController.class_eval { def rescue_action(e) raise e end }

class CartControllerTest < Test::Unit::TestCase
  def setup
    @controller = CartController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    
    # create two test products
    @product_a = Product.new
    @product_a.code = "PROD-A"
    @product_a.description = "Test product A."
    @product_a.price = 1.00
    @product_a.save!
    
    @product_b = Product.new
    @product_b.code = "PROD-B"
    @product_b.description = "Test product B."
    @product_b.price = 2.00
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
  
  def test_that_cart_total_is_calculated_correctly
    # insert five units of products A and B
    insert_into_cart( @product_a, 5 )
    insert_into_cart( @product_b, 5 )
    
    # a = 1, b = 2
    # 5a + 5b = 15
    assert session[:cart].total == 15.00
  end
  
  private
    def insert_into_cart( product, quantity = 1)
      post :add_or_update_in_cart, {:id => product.id, :quantity => quantity}
    end
end
