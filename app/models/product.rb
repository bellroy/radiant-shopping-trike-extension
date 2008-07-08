class Product < ActiveRecord::Base
  validates_exclusion_of :code, :in => %w{checkout cart eula}
  # path segment, see http://www.w3.org/Addressing/URL/5_URI_BNF.html
  validates_format_of :code, :with => /^[-a-z0-9_\.\$@&!\*"'\(\),]*$/i 
  validates_presence_of :code
  validates_uniqueness_of :code
  validates_presence_of :product_category

  has_many :product_prices, :dependent => :destroy
  has_many :coupons, :dependent => :destroy

  def product_price_for_quantity(quantity)
    self.product_prices.find(:first, :conditions => ['min_quantity <= ?', quantity], :order => 'min_quantity desc')
  end

  def first_product_price
    self.product_prices.find(:first, :order => 'min_quantity')
  end

  def price_for_quantity(quantity)
    pp = product_price_for_quantity(quantity)
    pp && pp.price.to_f
  end
  
  def total_for_quantity(quantity)
    price_for_quantity(quantity) * quantity
  end
  
  def price_and_total_for_quantity(quantity)
    [price_for_quantity(quantity), total_for_quantity(quantity)]
  end
  
  # savings_for_quantity(quantity)
  # returns percent that the unit price is more then price for that quantity
  # (ie if there is a 25% discount for the higher quantity, this will return
  # 50)
  # [ian: a. used price rather then total as quantity was common to both sides of division, b. should this show the discount percentage instead?]
  def savings_for_quantity(quantity)
    price_for_1 = price_for_quantity(1)
    price = price_for_quantity(quantity)
    return 0.00 if price_for_1 <= 0.0001  # dont divide by near zero
    100.0*(price_for_1 - price)/price_for_1
  end

end
