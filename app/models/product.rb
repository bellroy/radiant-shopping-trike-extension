class CurrencyException < Exception; end

class Product < ActiveRecord::Base
  validates_exclusion_of :code, :in => %w{checkout cart eula}
  # path segment, see http://www.w3.org/Addressing/URL/5_URI_BNF.html
  validates_format_of :code, :with => /^[-a-z0-9_\.\$@&!\*"'\(\),]*$/i 
  validates_presence_of :code
  validates_uniqueness_of :code
  validates_presence_of :product_category

  has_many :product_prices, :dependent => :destroy
  has_many :coupons, :dependent => :destroy

  BASE_CURRENCY = 'USD'

  def self.exchange_rate_for_currency(currency)
    return nil if currency == BASE_CURRENCY

    rate_key = "currency.#{BASE_CURRENCY.downcase}-#{currency.downcase}"
    rate = Radiant::Config[rate_key]

    raise CurrencyException, "No rate for currency '#{currency}'" if rate.nil?
    raise CurrencyException, "Rate for currency '#{currency}' is zero" if rate.to_f < 0.1
    return rate.to_f
  end

  def base_currency
    # Return a constant for now, in the future this might be an attribute
    BASE_CURRENCY
  end

  def product_price_for_quantity(quantity)
    self.product_prices.find(:first, :conditions => ['min_quantity <= ? AND `upgrade` != 1', quantity], :order => 'min_quantity desc')
  end

  def first_product_price
    self.product_prices.find(:first, :order => 'min_quantity')
  end

  def upgrade_price(currency)
    pp = self.product_prices.find(:first, :conditions => { :upgrade => true  })
    pp && price_in_currency(pp.price.to_f, currency)
  end

  def price_for_quantity(quantity, currency)
    pp = product_price_for_quantity(quantity)
    pp && price_in_currency(pp.price.to_f, currency)
  end
  
  def total_for_quantity(quantity, currency)
    price_for_quantity(quantity, currency) * quantity
  end
  
  def price_and_total_for_quantity(quantity, currency)
    [price_for_quantity(quantity, currency), total_for_quantity(quantity, currency)]
  end
  
  # savings_for_quantity(quantity)
  # returns percent that the unit price is more then price for that quantity
  # (ie if there is a 25% discount for the higher quantity, this will return
  # 50)
  # [ian: a. used price rather then total as quantity was common to both sides of division, b. should this show the discount percentage instead?]
  def savings_for_quantity(quantity, currency)
    price_for_1 = price_for_quantity(1, currency)
    price = price_for_quantity(quantity, currency)
    return 0.00 if price_for_1 <= 0.0001  # dont divide by near zero
    100.0*(price_for_1 - price)/price_for_1
  end

  # Rounds to nearest 5 minus 1
  def snap_to_round_amount(amount)
    snap_to = 5
    sign = amount < 0 ? -1 : 1
    amount = amount.abs
    quotient, modulus = amount.divmod(snap_to)

    rounded_amount = quotient * snap_to + (modulus >= snap_to / 2.0 ? snap_to : 0)
    rounded_amount = snap_to if rounded_amount == 0
    return sign * rounded_amount - sign
  end

  private
  
  def price_in_currency(amount, currency)
    return amount if amount.nil? or currency.upcase == base_currency
    
    snap_to_round_amount(amount * self.class.exchange_rate_for_currency(currency))
  end

end
