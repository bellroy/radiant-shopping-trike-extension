class ProductPrice < ActiveRecord::Base

  belongs_to :product

  validates_uniqueness_of :min_quantity, :scope => :product_id
  
  def validate
    errors.add(:price, "should be a positive value") if price.nil? || price < 0.01
  end
  
  def description
    upgrade ? 'upgrade' : min_quantity
  end

end
