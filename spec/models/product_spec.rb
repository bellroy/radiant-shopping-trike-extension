require File.dirname(__FILE__) + '/../spec_helper'

describe Product do
  
  describe 'total_for_quantity' do
    it 'should multiply price_for_quantity by qty' do
      p = Product.new
      p.stub!(:price_for_quantity).and_return(12.05)
      p.total_for_quantity(3).should == 12.05*3
    end
  end
  
end