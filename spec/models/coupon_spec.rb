require File.dirname(__FILE__) + '/../spec_helper'

describe Coupon do

  describe 'price_for_quantity' do
    
    it 'should be discount_per_order passed to amount_in_currency, rounded' do
      c = Coupon.new
      c.stub!(:discount_per_order).and_return('20.25')
      CurrencyConversion.should_receive(:amount_in_currency).with(
        -20.25, 
        'XTS',
        an_instance_of(Proc)
      ).and_return(-19.25)
      c.price_for_quantity(1, 'XTS').should == -19.25
    end
    
    it 'should be discount_per_order passed to amount_in_currency with AUD, rounded' do
      c = Coupon.new
      c.stub!(:discount_per_order).and_return('20.25')
      CurrencyConversion.should_receive(:amount_in_currency).with(
        -20.25,
        'AUD',
        an_instance_of(Proc)
      ).and_return(-32.0)
      c.price_for_quantity(1, 'AUD').should == -32.0
    end
    
  end

end
