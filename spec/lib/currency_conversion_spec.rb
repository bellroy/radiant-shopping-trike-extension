require File.dirname(__FILE__) + '/../spec_helper'

describe CurrencyConversion do

  require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

  describe 'base_currency' do
    
    it "should be USD" do
      CurrencyConversion.base_currency.should == 'USD'
    end
    
  end

  describe 'price_in_currency' do
    
    it 'should return the amount as is if currency is base currency' do
      Radiant::Config.should_not_receive(:[]).with(anything())
      CurrencyConversion.price_in_currency(:price, CurrencyConversion.base_currency).should == :price
    end

    it "should return nil if passed a nil amount" do
      Radiant::Config.should_not_receive(:[]).with(anything())
      CurrencyConversion.price_in_currency(nil, 'XTS').should be_nil
    end

    it 'should perform currency conversion and rounding when currency is not the base currency' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('2')
      CurrencyConversion.should_receive(:snap_to_round_amount).with(10.50).and_return(9.0)
      CurrencyConversion.price_in_currency(5.25, 'AUD').should == 9.0
    end
    
  end
  
  def self.should_snap(amount, expected_amount)
    it "should snap #{amount} to #{expected_amount}" do
      CurrencyConversion.snap_to_round_amount(amount).should == expected_amount
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
      CurrencyConversion.exchange_rate_for_currency(CurrencyConversion.base_currency).should be_nil
    end

    it 'should be a float when currency is not base_currency' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('1.31')
      CurrencyConversion.exchange_rate_for_currency('AUD').should be_close(1.31, 0.01)
    end

    it 'should raise a CurrencyException if the rate is not available' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return(nil)
      lambda { CurrencyConversion.exchange_rate_for_currency('AUD') }.should raise_error(CurrencyException)
    end

    it 'should raise a CurrencyException if the rate is very small' do
      Radiant::Config.should_receive(:[]).with('currency.usd-aud').and_return('0.09')
      lambda { CurrencyConversion.exchange_rate_for_currency('AUD') }.should raise_error(CurrencyException)
    end

  end

end
