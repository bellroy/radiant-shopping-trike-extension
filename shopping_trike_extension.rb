# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class ShoppingTrikeExtension < Radiant::Extension
  version "1.0"
  description "A shopping cart for RadiantCMS"
  url "http://code.trike.com.au/radiant/extensions/shopping_trike"
  
  define_routes do |map|
    map.connect 'admin/store/:action', :controller => 'store'
    map.connect 'shopping_trike/cart/:action', :controller => 'cart'
    map.connect 'shopping_trike/sitepoint/:action', :controller => 'site_point'
  end
  
  def activate
    StorePage
    SiteController.class_eval do
      session :disabled => false
    end
    
    admin.tabs.add "Products", "/admin/store", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    admin.tabs.remove "Store"
  end
end
