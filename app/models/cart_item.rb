class CartItem
  attr_reader :product
  attr_accessor :quantity
  
  def initialize(product, quantity, upgrade = false)
    @product = product
    @quantity = quantity
    @upgrade = upgrade
  end
  
  def code
    @product.code
  end
  
  def subtotal(currency, gst_charged = false)
    subtotal = 0
    if price(currency)
      subtotal = price(currency) * @quantity
      subtotal += @coupon.price_for_quantity(1, currency) if coupon?
      if gst_charged
        subtotal = round_to_cents(subtotal * 1.10)
      end
    end
    subtotal
  end

  def coupon?
    @coupon
  end

  def apply_coupon(coupon)
    @coupon = coupon
  end

  private
  
  def price(currency)
    @upgrade ? @product.upgrade_price(currency) : @product.price_for_quantity(@quantity, currency)
  end

  def round_to_cents(amount)
    (amount * 100.0).round.to_f / 100.0
  end


end
