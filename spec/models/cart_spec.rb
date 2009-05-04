require File.dirname(__FILE__) + '/../spec_helper'

describe Cart do

  describe 'when product is not an upgrade' do

    describe 'ex_gst_total' do

      it 'delegates to the cart item, passing currency and gst_charged' do
        p = Product.new
        cart = Cart.new('XTS', :gst_charged => true)

        cart_item = mock(CartItem)
        CartItem.stub!(:new).and_return(cart_item)

        cart_item.stub!(:quantity).and_return(1)
        cart_item.should_receive(:subtotal).with('XTS', false).and_return(88.95)

        cart.add_product_or_increase_quantity(p, 1)
        cart.ex_gst_total.should == 88.95
      end

    end

    describe 'total' do

      it 'delegates to the cart item, passing currency and gst_charged' do
        p = Product.new
        cart = Cart.new('XTS', :gst_charged => true)

        cart_item = mock(CartItem)
        CartItem.stub!(:new).and_return(cart_item)

        cart_item.stub!(:quantity).and_return(1)
        cart_item.should_receive(:subtotal).with('XTS', true).and_return(89.95)

        cart.add_product_or_increase_quantity(p, 1)
        cart.total.should == 89.95
      end

    end

    describe 'gst_amount' do
      
      it 'is total minus ex_gst_total' do
        p = Product.new
        cart = Cart.new('XTS', :gst_charged => true)

        cart.should_receive(:ex_gst_total).with(no_args()).and_return(20)
        cart.should_receive(:total).with(no_args()).and_return(30)

        cart.add_product_or_increase_quantity(p, 1)
        cart.gst_amount.should == 10
      end
      
    end

  end
  
  describe 'when product is an upgrade' do
    
    it "uses product.upgrade to calculate price when product is an upgrade" do
      p = Product.new
      cart = Cart.new('XTS', :gst_charged => false)

      p.should_receive(:upgrade_price).with('XTS').twice.and_return(99.95)

      cart.add_product_or_increase_quantity(p, 1, true)
      cart.total.should == 99.95
    end

  end

end
