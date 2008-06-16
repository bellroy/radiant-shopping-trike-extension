class Admin::ProductPriceController < Admin::AbstractModelController
  model_class ProductPrice
  def new
    product = Product.find(params[:product_id])
    product_price = product.product_prices.build
    # this is silly
    # product_price.product = product unless product_price.product

    self.model = product_price
    render :template => "admin/#{ model_symbol }/edit" if handle_new_or_edit_post
  end
end
