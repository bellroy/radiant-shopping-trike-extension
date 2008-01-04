class StorePage < Page

  description %{
    A store page provides access to child pages for individual Products, and
    other tags that will prove useful.
  }
  
  include Radiant::Taggable

  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    if is_a_child_product_page?(url)
      if product_from_url(url)
        self
      else
        nil
      end
    else
      super
    end
  end
  
  tag "code" do |tag|
    product.code
  end

  tag "attempted_url" do
    CGI.escapeHTML(request.request_uri) unless request.nil?
  end
  
  private

  def request_uri
    puts "\n\n\n--\n#{request.inspect}\n--\n\n\n"
    request.request_uri unless request.nil?
  end

  def is_a_child_product_page?(url)
    url =~ %r{^#{ self.url }([^/]+)/?$}
  end

  def product(request_uri = self.request_uri)
    code = $1 if request_uri =~ %r{#{parent.url}([^/]+)/?$}
    Product.find_by_code(code)
  end
  def product_from_url(url)
    product(url)
  end
  
end
