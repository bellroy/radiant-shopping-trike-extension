# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class ShoppingTrikeExtension < Radiant::Extension
  version "0.1"
  description "A simple cart for RadiantCMS"
  url "http://code.trike.com.au/svn/radiant/extensions/shopping_trike/"
  
  define_routes do |map|
    # map.connect 'admin/store/:action', :controller => 'store'
    # Product Routes
    map.with_options(:controller => 'admin/product') do |product|
      product.product_index  'admin/products',            :action => 'index'
      product.product_price_index  'admin/products',      :action => 'index'
      product.coupon_index  'admin/products',             :action => 'index'
      product.product_edit   'admin/products/edit/:id',   :action => 'edit'
      product.product_new    'admin/products/new',        :action => 'new'
      product.product_remove 'admin/products/remove/:id', :action => 'remove'
    end
    map.with_options(:controller => 'admin/product_price') do |product_price|
      product_price.product_price_edit   'admin/product_prices/edit/:id',                 :action => 'edit'
      product_price.product_price_new    'admin/products/:product_id/product_prices/new', :action => 'new'
      product_price.product_price_remove 'admin/product_prices/remove/:id',               :action => 'remove'
    end
    map.with_options(:controller => 'admin/coupon') do |coupon|
      # radiant does things very different. edit is edit AND new, and is POSTed to both, not PUT
      coupon.coupon_edit   'admin/coupons/edit/:id',                 :action => 'edit'
      coupon.coupon_new    'admin/products/:product_id/coupons/new', :action => 'new'
      coupon.coupon_remove 'admin/coupons/remove/:id',               :action => 'remove'
    end
    
    map.connect 'shopping_trike/cart/:action', :controller => 'cart'
  end
  
  def activate
    StorePage
    SiteController.class_eval do
      session :disabled => false
    end
    
    admin.tabs.add "Products", "/admin/products", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    admin.tabs.remove "Products"
  end
end
