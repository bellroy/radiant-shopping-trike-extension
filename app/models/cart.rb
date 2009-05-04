class Cart
  attr_reader :items
  attr_accessor :id
  attr_accessor :gst_charged
  attr_accessor :currency
  
  def initialize(currency, options = {:gst_charged => true})
    @currency = currency
    @items = []
    options.each_pair {|k, v| self.send(:"#{k}=", v) }
  end
  
  def add_product_or_increase_quantity(product, quantity, upgrade = false)
    if product.is_a?(Coupon)
      matching_product = cart_item_for_product( product.product )
      if coupon || (quantity > 1)
        raise(ArgumentError, "You can only add one Coupon per order")
      elsif matching_product.nil? 
        raise(ArgumentError, "Invalid coupon (no matching products in your cart)")
      elsif !product.current?
        raise(ArgumentError, "Coupon has expired or is otherwise not valid")
      else
        matching_product.apply_coupon(product)
      end
    else # product is a Product
      current_item = cart_item_for_product( product )
      if current_item
        current_item.quantity += quantity
      else
        current_item = CartItem.new(product, quantity, upgrade)
        @items << current_item
      end
    end
    tidy
  end
  
  def set_quantity(product, quantity)
    current_item = cart_item_for_product( product )
    current_item.quantity = quantity
    tidy
  end
  
  def override_with_product_quantity(product, quantity)
    current_item = CartItem.new(product, quantity)
    @items = [ current_item ]
    tidy
  end
  
  def remove_product( product )
    item = cart_item_for_product( product )
    @items.delete( item ) if item
  end
  
  def quantity_of_product( product )
    item = cart_item_for_product( product )
    item.quantity if item
  end
  
  def gst_charged?
    @gst_charged
  end
  
  def ex_gst_total
    grand_total = 0
    items.each do |item|
      grand_total += item.subtotal(@currency, false)
    end
    grand_total
  end

  def total
    grand_total = 0
    items.each do |item|
      grand_total += item.subtotal(@currency, @gst_charged)
    end
    grand_total
  end

  def gst_amount
    total - ex_gst_total
  end

  private
    def cart_item_for_product( product )
       items.find {|item| item.product == product}
    end
    
    def tidy
      items.each do |item|
        # every item must have a quantity of at least one
        remove_product( item.product ) if item.quantity < 1
      end
    end

    def coupon
      item = items.select {|item| item.coupon? }.first
      item.product if item
    end

end
