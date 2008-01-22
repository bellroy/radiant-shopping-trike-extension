class CartItem
  attr_reader :product
  attr_accessor :quantity
  
  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end
  
  def code
    @product.code
  end
  
  def subtotal_price
    @product.price * @quantity
  end
end