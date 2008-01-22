class Cart
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def add_product_or_increase_quantity(product, quantity)
    current_item = cart_item_for_product( product )
    if current_item
      current_item.quantity += quantity
    else
       current_item = CartItem.new(product, quantity)
       @items << current_item
    end
    
    tidy
  end
  
  def set_quantity(product, quantity)
    current_item = cart_item_for_product( product )
    current_item.quantity = quantity
  
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
  
  def total
    grand_total = 0
    items.each do |item|
      grand_total += item.subtotal_price
    end
    grand_total
  end
  
  private
    def cart_item_for_product( product )
       @items.find {|item| item.product == product}
    end
    
    def tidy
      @items.each do |item|
        # every item must have a quantity of at least one
        remove_product( item.product ) if item.quantity < 1
      end
    end
end
