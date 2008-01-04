# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ShoppingTrikeExtension < Radiant::Extension
  version "1.0"
  description "A shopping cart for RadiantCMS"
  url "http://code.trike.com.au/radiant/extensions/shopping_trike"
  
  define_routes do |map|
    map.connect 'admin/store/:action', :controller => 'store'
  end
  
  def activate
    StorePage
    admin.tabs.add "Store", "/admin/store", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    admin.tabs.remove "Store"
  end
  
end
