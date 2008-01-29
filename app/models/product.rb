class Product < ActiveRecord::Base
  validates_exclusion_of :code, :in => %w{checkout cart eula}
  validates_presence_of :code
  
  def validate
    errors.add(:price, "should be a positive value") if price.nil? || price < 0.01
  end
end
