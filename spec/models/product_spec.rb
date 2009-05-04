require File.dirname(__FILE__) + '/../spec_helper'

describe Product do

  describe 'price_for_quantity' do
    
    it 'should be product_price.price when the supplied currency is the base currency' do
      p = Product.new
      product_price = stub(ProductPrice, :price => 99.95)
      p.stub!(:product_price_for_quantity).and_return(product_price)
      p.price_for_quantity(1, p.base_currency).should == 99.95
    end

    it 'should perform currency conversion and rounding when supplied currency is not the base currency' do
      p = Product.new
      product_price = stub(ProductPrice, :price => 50)
      p.stub!(:product_price_for_quantity).and_return(product_price)
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('2')
      p.price_for_quantity(1, 'AUD').should == 99
    end
    
  end
  
  describe 'upgrade_price' do
    
    it 'should be product_price.price when the supplied currency is the base currency' do
      p = Product.new
      product_price = stub(ProductPrice, :price => 24.95)
      product_prices = mock('product_prices')
      p.should_receive(:product_prices).and_return(product_prices)
      product_prices.should_receive(:find).with(
        :first,
        :conditions => {:upgrade => true}
      ).and_return(product_price)

      p.upgrade_price(p.base_currency).should == 24.95
    end
  
    it 'should perform currency conversion and rounding when supplied currency is not the base currency' do
      p = Product.new
      product_price = stub(ProductPrice, :price => 24.95)
      product_prices = mock('product_prices')
      p.should_receive(:product_prices).and_return(product_prices)
      product_prices.should_receive(:find).with(
        :first,
        :conditions => {:upgrade => true}
      ).and_return(product_price)
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('2')

      p.upgrade_price('AUD').should == 49.0
    end
    
  end

  describe 'total_for_quantity' do
    it 'should multiply price_for_quantity by qty' do
      p = Product.new
      p.stub!(:price_for_quantity).and_return(12.05)
      p.total_for_quantity(3, p.base_currency).should == 12.05*3
    end
  end

  def self.should_snap(amount, expected_amount)
    it "should snap #{amount} to #{expected_amount}" do
      Product.new.snap_to_round_amount(amount).should == expected_amount
    end
  end

  describe 'snap_to_round_amount' do
    
    should_snap 1, 4.0
    should_snap 2.25, 4.0
    should_snap 3.9, 4.0
    should_snap 100.12345, 99.0
    should_snap 8.9823, 9.0
    should_snap 480.39, 479.0
    should_snap 7.39, 4.0
    should_snap 83.398, 84.0
    should_snap 47.19, 44.0
    should_snap 7, 4
    should_snap -1, -4
    should_snap -3, -4
    should_snap -7, -4
    should_snap -7.6, -9
    should_snap -11, -9
    
  end

  describe 'exchange_rate_for_currency' do

    it 'should should be nil when currency is base_currency' do
      Radiant::Config.should_not_receive(:[]).with(anything())
      Product.exchange_rate_for_currency(Product::BASE_CURRENCY).should be_nil
    end
  
    it 'should be a float when currency is not base_currency' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('1.31')
      Product.exchange_rate_for_currency('AUD').should be_close(1.31, 0.01)
    end
    
    it 'should raise a CurrencyException if the rate is not available' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return(nil)
      lambda { Product.exchange_rate_for_currency('AUD') }.should raise_error(CurrencyException)
    end

    it 'should raise a CurrencyException if the rate is very small' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('0.09')
      lambda { Product.exchange_rate_for_currency('AUD') }.should raise_error(CurrencyException)
    end

  end

end
