class AddProductCategory < ActiveRecord::Migration
  def self.up
    add_column :products, :product_category, :string
    execute "update products set product_category = 'bCisive' where description like '%isive%'"
    execute "update products set product_category = 'Rationale' where description like '%ational%'"
  end

  def self.down
    remove_column :products, :product_category
  end
end
