require File.dirname(__FILE__) + '/../test_helper'

class CartTest < Test::Unit::TestCase

  def setup
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    
    Product.delete_all
    ProductPrice.delete_all
  end

  def test_totals_of_empty_cart
    cart = Cart.new
    assert_equal 0.00, cart.ex_gst_total
    assert_equal 0.00, cart.gst_amount
    assert_equal true, cart.gst_charged
    assert_equal 0.00, cart.total
  end

  def test_gst_charged_totals
    cart = create_valid_cart
    assert_equal 100.00, cart.ex_gst_total
    assert_equal 10.00, cart.gst_amount
    assert_equal true, cart.gst_charged
    assert_equal 110.00, cart.total
  end

  def test_gst_free_charged_totals
    cart = create_valid_cart
    cart.gst_charged = false
    assert_equal 100.00, cart.ex_gst_total
    assert_equal 0.00, cart.gst_amount
    assert_equal false, cart.gst_charged
    assert_equal 100.00, cart.total
  end

  def test_that_coupon_can_not_be_added_unless_it_is_current
    cart = create_valid_cart
    product = cart.items.first.product
    coupon = product.coupons.build(:discount_per_order => 43.23)
    coupon.stubs(:current?).returns(false)

    assert_raise ArgumentError, "I should not be able to add an expired coupon to a cart." do
      cart.add_product_or_increase_quantity(coupon, 1)
    end
  end
  def test_that_coupon_can_not_be_added_unless_it_is_valid_for_a_product
    cart = create_valid_cart
    coupon = Coupon.new

    assert_raise ArgumentError, "I should not be able to add an invalid coupon to a cart." do
      cart.add_product_or_increase_quantity(coupon, 1)
    end
  end
  
  def test_that_a_coupon_is_applied_to_the_relevant_product_when_added
    cart = create_valid_cart
    product_item = cart.items.first
    coupon = product_item.product.coupons.build(:discount_per_order => 23.32)
    product_item.expects(:apply_coupon).with(coupon)

    cart.add_product_or_increase_quantity(coupon, 1)
  end

  def test_that_only_one_coupon_can_be_added
    cart = create_valid_cart(:with_coupon => true)
    product = cart.items.first.product
    second_coupon = product.coupons.build()
    

    assert_raise ArgumentError, "I should not be able to add a second coupon to a cart." do
      cart.add_product_or_increase_quantity(second_coupon, 1)
    end
  end

  def test_totals_with_coupon
    cart = create_valid_cart(:with_coupon => true)

    cart.gst_charged = false
    assert_equal 56.77, cart.ex_gst_total
    assert_equal 0.00, cart.gst_amount
    assert_equal false, cart.gst_charged
    assert_equal 56.77, cart.total

    cart.gst_charged = true
    assert_equal 56.77, cart.ex_gst_total
    assert_equal 5.68, cart.gst_amount
    assert_equal true, cart.gst_charged
    assert_equal 62.45, cart.total
  end

  def test_items_with_coupon_should_not_include_coupon
    cart = create_valid_cart(:with_coupon => true)

    assert (cart.items.select {|i| i.product.is_a?(Coupon) }.empty?), "Coupon is present in Cart#items"
  end
  def test_items_with_coupon_should_apply_coupon_to_first_product
    cart = create_valid_cart(:with_coupon => true)

    assert(cart.items.select {|i| i.product.is_a?(Coupon) }.empty?,
           "Coupon is present in Cart#products")
    assert_equal(56.77, cart.items.select {|i| i.product.is_a?(Product) }.first.subtotal,
                 "Coupon is present in Cart#products")
  end

  private

  def create_valid_cart(options = {:with_coupon => false})
    product = Product.new(:code => 'PP001', :description  => 'test product', :product_category => 'bCisive')
    product.product_prices << ProductPrice.new(:min_quantity => 0, :price => 100.00)
    product.save!
    cart = Cart.new
    cart.add_product_or_increase_quantity(product, 1)
    if options[:with_coupon]
      coupon = product.coupons.build(:discount_per_order => 43.23)
      cart.add_product_or_increase_quantity(coupon, 1)
    end
    cart
  end

end
