require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'admin/product/edit' do
  def instance
    Product.new
  end
  
  def self.fields
    {
      :code => 'CODE',
      # :description => 'a description', # need text_area checking instead
      :product_category => 'bCisive'
    }
  end

  it_should_behave_like 'edit_page'
end