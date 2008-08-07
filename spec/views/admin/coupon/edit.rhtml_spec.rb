require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'admin/coupon/edit' do
  def instance
    Coupon.new(:product => Product.new)
  end
  
  def self.fields
    {
      :code => 'CODE',
      :expiration_date => '2008-01-01',
      :discount_per_order => 250.0
    }
  end

  it_should_behave_like 'edit_page'
end