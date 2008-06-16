module  Admin::ProductHelper
  def currently_used_product_categories
    Product.find_by_sql("select product_category from products group by product_category;").collect {|p| "'#{p.product_category}'" }.to_sentence
  end
  def dom_id(record, prefix = nil) 
    prefix ||= 'new' unless record.id
    [ prefix, record.class.name.singularize, record.id ].compact * '_'
  end
end
