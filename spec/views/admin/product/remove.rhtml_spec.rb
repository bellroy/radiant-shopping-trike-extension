require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'admin/product/remove' do
  it 'should render' do
    assigns[:product] = Product.new
    render 'admin/product/remove'
  end  
end