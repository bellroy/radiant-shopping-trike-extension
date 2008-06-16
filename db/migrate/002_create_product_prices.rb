class CreateProductPrices < ActiveRecord::Migration
  def self.up
    create_table :product_prices do |t|
      t.column :product_id, :integer
      t.column :min_quantity, :integer
      t.column :price, :decimal, :precision => 8, :scale => 2, :default => 0
    end
    execute "insert into product_prices(product_id, min_quantity, price) select id, 0, price from products"
    execute "insert into product_prices(product_id, min_quantity, price) select id, 5, price*0.95 from products"
    execute "insert into product_prices(product_id, min_quantity, price) select id, 25, price*0.9 from products"
    execute "insert into product_prices(product_id, min_quantity, price) select id, 50, price*0.8 from products"
    remove_column :products, :price
  end

  def self.down
    drop_table :product_prices
    add_column :products, :price, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
