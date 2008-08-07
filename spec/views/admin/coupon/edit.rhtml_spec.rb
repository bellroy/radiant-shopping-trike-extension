require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/coupons/edit"  do
  before(:each) do
    @coupon = Coupon.new(:product => Product.new)
    @coupon.stub!(:id).and_return(1)
    assigns[:coupon] = @coupon
  end
  
  def render_edit
    render "/admin/coupon/edit"
  end
  
  it 'should successfully render' do
    render_edit
    
    response.should be_success
  end  
    
  it 'should get authenticity token' do
    template.should_receive(:form_authenticity_token)
    
    render_edit
  end
  
  it 'should ask for new record (for form builder)' do
    @coupon.should_receive(:new_record?).at_least(:once).and_return(false)
    
    render_edit
  end
  
  describe 'form' do
    it 'should include the authenticity token in a hidden input' do
      template.stub!(:form_authenticity_token).and_return('MY SUPER SECRET TOKEN')
      render_edit  
      puts response.body
      response.should have_tag("form[action=''][method=post]") do
        with_tag("input[type='hidden'][name='authenticity_token'][value=?]", 'MY SUPER SECRET TOKEN')
      end
    end
    
    
    it 'should post to itself' do
      # Posting to '' is kinda silly. Should be using RESTful routing
      render_edit

      response.should have_tag("form[action=''][method=post]")
    end
      
    describe 'input fields' do
      it 'should include code' do
        @coupon.code = 'CODE'
        render_edit
      
        response.should have_tag("input[type='text'][name='coupon[code]'][value=?]", @coupon.code)
      end
      it 'should include expiration date' do
        @coupon.expiration_date = '2008-01-01'
        render_edit
        
        response.should have_tag("input[type='text'][name='coupon[expiration_date]'][value=?]", @coupon.expiration_date)
      end          
      it 'should include discount per order' do
        @coupon.discount_per_order = 250.0
        render_edit
  
        response.should have_tag("input[type='text'][name='coupon[discount_per_order]'][value=?]", @coupon.discount_per_order)
      end
    end
  end
end