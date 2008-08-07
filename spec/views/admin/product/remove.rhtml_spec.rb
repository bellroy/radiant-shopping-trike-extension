require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'admin/product/remove' do  
  def render_remove
    render 'admin/product/remove'
  end
  
  before(:each) do
    assigns[:product] = Product.new
  end
  
  it 'should render' do
    render_remove
  end  
  
  it 'should include the authenticity token in a hidden input' do
    template.stub!(:form_authenticity_token).and_return('MY SUPER SECRET TOKEN')
    render_remove  

    response.should have_tag("form") do
      with_tag("input[type='hidden'][name='authenticity_token'][value=?]", 'MY SUPER SECRET TOKEN')
    end
  end
  
  it 'should post the form' do
    render_remove
    response.should have_tag("form[method='post']", :count => 1)
  end
end