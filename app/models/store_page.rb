class StorePage < Page
  description %{
    A store page provides access to child pages for individual Products, and
    other tags that will prove useful.
  }
  
  def process( request, response )
    @session = request.session
    super( request, response )
  end
  
  def cache?
    false
  end
  
  include Radiant::Taggable
  
  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    
    assess_page_type_from_url_and_load_models(url)

    if @page_type
      self
    else
      super
    end
  end
  
  def tag_part_name(tag)
    case @page_type
    when :product
      tag.attr['part'] || 'product'
    when :cart
      tag.attr['part'] || 'cart'
    when :checkout
      tag.attr['part'] || 'checkout'
    else
      tag.attr['part'] || 'body'
    end
  end
  
  # The cart page is rendered via AJAX and inserted into complete pages it must not include
  # a layout.
  def render
    if @page_type == :cart
      render_part( :cart )
    else
      super
    end
  end
  
  tag "shopping" do |tag|
    tag.expand
  end
  
  tag "shopping:product" do |tag|
    tag.expand
  end
  
  tag "shopping:product:each" do |tag|
    result = []
    Product.find(:all).each do |item|
      @product = item
      result << tag.expand
    end
    result
  end
  
  tag "shopping:product:addtocart" do |tag|
    [CartController.form_to_add_or_update_product_in_cart( @product )]
  end
  
  tag "shopping:product:code" do |tag|
    @product.code
  end
  
  tag "shopping:product:description" do |tag|
    @product.description
  end
  
  tag "shopping:product:price" do |tag|
    @product.price
  end

  tag "shopping:product:link" do |tag|
    [link("/#{slug}/" + @product.code, tag.expand)]
  end

  tag "shopping:cart" do |tag|
    tag.expand
  end

  tag "shopping:cart:form" do |tag|
    result = []
    if @page_type == :cart
      result << CartController.cart_form_start_fragment
      result << tag.expand
      result << CartController.cart_form_end_fragment
    else
      result << %Q(<div id="#{ CartController.cart_ajaxify_form_div_id }">) 
      
      result << CartController.cart_form_start_fragment
      result << tag.expand
      result << CartController.cart_form_end_fragment
      
      result << "</div>"
      result << CartController.cart_ajaxify_script( slug )
    end
    result
  end

  tag "shopping:cart:total" do |tag|
    cart = get_or_create_cart
    cart.total
  end
  
  tag "shopping:cart:empty" do |tag|
    [CartController.cart_form_fragment_to_empty_cart]
  end
  
  tag "shopping:cart:checkout" do |tag|
    [link("/#{ slug }/checkout/", "checkout")]
  end
  
  tag "shopping:cart:update" do |tag|
    [CartController.cart_form_fragment_to_update_cart]
  end
  
  tag "shopping:cart:item" do |tag|
    tag.expand
  end
  
  tag "shopping:cart:item:each" do |tag|
    result = []
    cart = get_or_create_cart
    if cart.items.length == 0
      result << "(empty)"
    else
      cart.items.each do |item|
        @cart_item = item
        result << tag.expand
      end
    end
    result
  end

  tag "shopping:cart:item:code" do |tag|
    @cart_item.product.code
  end

  tag "shopping:cart:item:quantity" do |tag|
    @cart_item.quantity
  end

  tag "shopping:cart:item:unitcost" do |tag|
    @cart_item.product.price
  end

  tag "shopping:cart:item:subtotal" do |tag|
    @cart_item.product.price * @cart_item.quantity
  end

  tag "shopping:cart:item:remove" do |tag|
    [CartController.cart_form_fragment_to_remove_an_item_currently_in_cart( @cart_item.product )]
  end

  tag "shopping:cart:item:update" do |tag|
    [CartController.cart_form_fragment_to_alter_an_item_quantity_in_cart( @cart_item.product, @cart_item.quantity )]
  end

  tag "shopping:attempted_url" do |tag|
    CGI.escapeHTML(request.request_uri) unless request.nil?
  end
  
  tag "shopping:checkout" do |tag|
    tag.expand
  end
  
  tag "shopping:checkout:process" do |tag|
    [CartController.form_to_payment_processor( tag.attr['processor_url'], tag.attr['next_url'] )]
  end
  
  private
    def link( url, text )
       %Q(<a href="#{ url }">#{ text }</a>)
    end

    def get_or_create_cart
      @session[:cart] ||= Cart.new
    end

    def assess_page_type_from_url_and_load_models(url)
      if is_a_child_page?(url)
        page_type_and_required_models(url)
      end
    end

    def request_uri
      puts "\n\n\n--\n#{request.inspect}\n--\n\n\n"
      request.request_uri unless request.nil?
    end

    def is_a_child_page?(url)
      url =~ %r{^#{ self.url }([^/]+)/?$}
    end

    def page_type_and_required_models(request_uri = self.request_uri)
      code = $1 if request_uri =~ %r{#{parent.url unless parent.nil?}([^/]+)/?$}
      if code =~ %r{^cart}
        @page_type = :cart
      elsif code =~ %r{^checkout}
        @page_type = :checkout
      else
        @product = Product.find_by_code(code)
        @page_type = :product if @product
      end
    end
  
    def product_or_cart_from_url(url)
      product_or_cart(url)
    end
end
