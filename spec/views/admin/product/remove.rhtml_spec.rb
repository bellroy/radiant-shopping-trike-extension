require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'admin/product/remove' do  
  def instance; Product.new; end
  def action; 'remove'; end
  
  it_should_behave_like 'protected_from_forgery'
end