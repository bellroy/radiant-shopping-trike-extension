class ProductPage < Page

  description %{
    A product page shows product details for a Product.
  }
  
  include Radiant::Taggable

  tag "code" do |tag|
    product.code
  end
  
  private

  def request_uri
    request.request_uri unless request.nil?
  end

  def product
    code = $1 if request_uri =~ %r{/#{parent.url}/([^/]+)/?$}
    Product.find_by_code(code)
  end
end

