require File.dirname(__FILE__) + '/../spec_helper'

describe Product do

  describe 'price_for_quantity' do
    
    it 'should be product_price.price passed to amount_in_currency' do
      p = Product.new
      product_price = stub(ProductPrice, :price => 99.95)
      p.stub!(:product_price_for_quantity).and_return(product_price)
      CurrencyConversion.should_receive(:amount_in_currency).with(
        99.95,
        'XTS',
        an_instance_of(Proc)
      ).and_return(99.00)
      p.price_for_quantity(1, 'XTS').should == 99.00
    end
    
  end
  
  describe 'upgrade_price' do
    
    it 'should be product_price.price passed to amount_in_currency' do
      p = Product.new
      product_price = stub(ProductPrice, :price => 24.95)
      product_prices = mock('product_prices')
      p.should_receive(:product_prices).and_return(product_prices)
      product_prices.should_receive(:find).with(
        :first,
        :conditions => {:upgrade => true}
      ).and_return(product_price)
      CurrencyConversion.should_receive(:amount_in_currency).with(
        24.95,
        'XTS',
        an_instance_of(Proc)
      ).and_return(24.95)
      p.upgrade_price('XTS').should == 24.95
    end
  
  end

  describe 'total_for_quantity' do
    it 'should multiply price_for_quantity by qty' do
      p = Product.new
      p.stub!(:price_for_quantity).and_return(12.05)
      p.total_for_quantity(3, 'XTS').should == 12.05*3
    end
  end

end
