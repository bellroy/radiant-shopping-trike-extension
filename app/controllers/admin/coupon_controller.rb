class Admin::CouponController < Admin::AbstractModelController
  model_class Coupon  
  def new
    product = Product.find(params[:product_id])
    coupon = product.coupons.build
    # this is silly
    # coupon.product = product unless coupon.product

    self.model = coupon
    render :template => "admin/#{ model_symbol }/edit" if handle_new_or_edit_post
  end
end
