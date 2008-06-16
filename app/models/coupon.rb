class Coupon < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product, :code
  validates_uniqueness_of :code, :scope => :product_id
  validates_associated :product
  validates_numericality_of :discount_per_order
  validates_each :discount_per_order  do |record, attr, value|
    record.errors.add attr, "must be positive." unless value > 0.0
  end

  def price_for_quantity(qty)
    current? ? -discount_per_order.to_f / qty.to_f : 0
  end
  
  def current?
    if expiration_date
      Date.today <= expiration_date
    else
      true
    end
  end
end
