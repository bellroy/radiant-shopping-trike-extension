class StorePage < Page

  description %{
    A store page provides access to child pages for individual Products, and
    other tags that will prove useful.
  }
  
  include Radiant::Taggable

  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    if is_a_child_product_page?(url)
      code = $1
      if product
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
  
  private

  def request_uri
    request.request_uri unless request.nil?
  end

  def is_a_child_product_page?(url)
    url =~ %r{^#{ self.url }([^/]+)/?$}
  end

  def product
    code = $1 if request_uri =~ %r{/#{parent.url}/([^/]+)/?$}
    Product.find_by_code(code)
  end
  
end

