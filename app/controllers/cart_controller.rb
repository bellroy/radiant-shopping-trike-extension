require 'net/https'
require 'uri'
require 'digest/md5'

class CartController < ActionController::Base
  def add_or_update_in_cart
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to add invalid product to cart using product id: #{params[:id]}")
    else
      @cart = find_cart
      @cart.add_product_or_increase_quantity(product, params[:quantity].to_i)
    end
    redirect_to :back
  end

  def process_cart_change
    # determine which input was used to submit the cart and update or remove accordingly
    if params[:submit_type] == "update" || params[:submit_type] == "notajax" && params[:update_submit]
      params[:update].each do |k,v|
        update_in_cart( k.to_i, v.to_i )
      end
    elsif params[:submit_type] == "remove" || params[:submit_type] == "notajax" && params[:remove_submit]
      params[:remove_submit].each do |k,v|
        # the key contains the product id inserted into the input tag
        remove_from_cart k.to_i
      end
    elsif params[:submit_type] == "empty" || params[:submit_type] == "notajax" && params[:empty_submit]
      empty_cart
    end
    
    redirect_to :back
  end
  
  def submit_to_processor
    # do nothing if the user did not accept the eula
    redirect_to :back and return unless params[:agree]
    
    
    uri = URI.parse( params[:processor_url] )
    site = Net::HTTP.new( uri.host, uri.port )
    res = site.post( uri.path, contents_xml, { 'Content-Type' => 'text/xml; charset=utf-8' } )

    raise "Processor did not respond with status 200. Instead gave " + res.code.to_s unless res.code == "200"

    logger.debug "Response from order processor contained: " + res.body
    
    cart = find_cart
    
    redirect_to params[:next_url] + "?cart=#{cart.id}"
  end
  
  def self.form_to_add_or_update_product_in_cart( product )
    %Q( <form action="/shopping_trike/cart/add_or_update_in_cart" method="post"
          onsubmit="new Ajax.Request('/shopping_trike/cart/add_or_update_in_cart',
            {asynchronous:true, evalScripts:true, parameters:Form.serialize(this), onSuccess:cart_update}); return false;">
          <input type="hidden" id="product_id" name="id" value="#{ product.id }" />
          <input id="product_quantity" name="quantity" size="5" type="text" />
          <input name="commit" type="submit" value="add to cart" />
        </form> )
  end
  
  def self.cart_form_start_fragment
    %Q( <form action="/shopping_trike/cart/process_cart_change" method="post" id="shopping_trike_cart_form" onsubmit="new Ajax.Request('/shopping_trike/cart/process_cart_change',
      {asynchronous:true, evalScripts:true, parameters:Form.serialize(this), onSuccess:cart_update}); return false;">
      <input type="hidden" id="submit_type" name="submit_type" value="notajax" /> )
  end
  
  def self.cart_form_end_fragment
    %Q( </form> )
  end
  
  def self.cart_form_fragment_to_remove_an_item_currently_in_cart( product )
    %Q( <input name="remove_submit[#{ product.id }]" type="submit" value="remove" onclick="Form.getInputs(this.form, null, 'submit_type')[0].value = 'remove'" /> )
  end
  
  def self.cart_form_fragment_to_alter_an_item_quantity_in_cart( product, quantity )
    %Q( <input name="update[#{ product.id }]" type="text" size="5" value="#{ quantity }" /> )
  end
  
  def self.cart_form_fragment_to_empty_cart
    %Q( <input name="empty_submit" type="submit" value="empty" onclick="Form.getInputs(this.form, null, 'submit_type')[0].value = 'empty'" /> )
  end
  
  def self.cart_form_fragment_to_update_cart
    %Q( <input name="update_submit" type="submit" value="update" onclick="Form.getInputs(this.form, null, 'submit_type')[0].value = 'update'"/> )
  end
  
  def self.cart_ajaxify_form_div_id
    "shopping_trike_cart"
  end
  
  def self.form_to_payment_processor( processor_url, next_url, eula_label_text )
    %Q( <form action="/shopping_trike/cart/submit_to_processor" method="post">
          <input type="hidden" name="processor_url" value="#{ processor_url }" />
          <input type="hidden" name="next_url" value="#{ next_url }" />
          <input type="checkbox" name="agree" value="yes" /> #{ eula_label_text }<br/>
          <input name="submit_process" value="create order" type="submit"/>
        </form>)
  end
  
  def self.cart_ajaxify_script( url_base )
    %Q( <script type="text/javascript">
          function cart_update()
          {
            new Ajax.Updater('shopping_trike_cart', '/#{url_base}/cart', { method: 'get' });
          }
        </script> )
  end
  
  private
    def update_in_cart( prod_id, quantity )
      cart = find_cart
      product = Product.find_by_id( prod_id )
      cart.set_quantity( product, quantity )
    end
    
    def remove_from_cart( prod_id )
      cart = find_cart
      product = Product.find_by_id( prod_id )
      cart.remove_product( product )
    end
  
    def find_cart
      unless session[:cart]
        session[:cart] = Cart.new
      end
      session[:cart]
    end
  
    def empty_cart
      session[:cart] = Cart.new
    end
    
    def contents_xml
      cart = find_cart
      cart.id = create_cart_id
      cart.xml
    end
    
    # This is similar to how session keys are generated. Use this for unique cart ids and
    # _never_ use the session key as we may open ourselves to fixation attacks.
    def create_cart_id
      md5 = Digest::MD5::new
      now = Time::now
      md5.update(now.to_s)
      md5.update(String(now.usec))
      md5.update(String(rand(0)))
      md5.update(String($$))
      md5.update('foobar')
      md5.hexdigest
    end
end
