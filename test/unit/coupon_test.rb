require File.dirname(__FILE__) + '/../test_helper'

class CouponTest < Test::Unit::TestCase
  def test_that_associated_product_must_exist
    coupon = Coupon.new
    coupon.valid?

    assert coupon.errors.on(:product)
  end
  def test_that_associated_product_must_be_valid
    product = stub_everything(:valid? => false, :is_a? => true, :id => 1)
    coupon = Coupon.new(:product => product)
    coupon.valid?

    assert coupon.errors.on(:product)
  end
  def test_that_reasonable_currency_values_can_be_stored_and_retrieved
    coupon = Coupon.new
    coupon.stubs(:valid?).returns(true)
    coupon.save

    [0, 0.12, 42.42].each do |price|
      coupon.discount_per_order = price
      coupon.save!
      coupon.reload
      assert (price - coupon.discount_per_order.to_f).abs < 0.001, "#{price} didn't come back out of a database round trip equalling what we expected, it was #{coupon.discount_per_order.inspect}"
    end
  end
  def test_that_discount_per_order_must_not_be_negative
    coupon = Coupon.new(:discount_per_order => -1)
    coupon.valid?

    assert coupon.errors.on(:discount_per_order)
  end
  def test_that_price_for_quantity_is_such_that_order_discount_is_constant
    discount = 56.32
    coupon = Coupon.new(:discount_per_order => discount)

    assert_equal -discount/34, coupon.price_for_quantity(34)
  end
  
  def test_that_coupon_has_price_of_zero_if_expired
    coupon = Coupon.new(:expiration_date => 3.months.ago.to_date.to_s, :discount_per_order => 100)
    assert_equal 0, coupon.price_for_quantity(1)
  end
  
  def test_that_coupon_with_no_expiration_date_is_always_valid
    coupon = Coupon.new(:expiration_date => '')
    assert coupon.current?, "coupon should be current"
  end
  
  def test_that_coupon_with_expiration_date_in_future_is_valid
    Date.stubs(:today).returns(Date.new(2008,6,6))
    coupon = Coupon.new(:expiration_date => '2008-12-12')
    
    assert coupon.current?, "coupon should be current"
  end

  def test_that_coupon_with_expiration_date_in_past_is_valid
    Date.stubs(:today).returns(Date.new(2008,6,6))
    coupon = Coupon.new(:expiration_date => '2008-01-01')
    
    assert !coupon.current?, "coupon should be current"
  end
end
