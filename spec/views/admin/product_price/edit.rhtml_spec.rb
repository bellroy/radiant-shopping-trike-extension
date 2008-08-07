require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'admin/product_price/edit' do
  def instance
    ProductPrice.new(:product => Product.new)
  end

  def self.fields
    {
      :min_quantity => 100,
      :price => 49.95
    }
  end

  it_should_behave_like 'edit_page'
end