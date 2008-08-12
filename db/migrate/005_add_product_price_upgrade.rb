class AddProductPriceUpgrade < ActiveRecord::Migration
  def self.up
    add_column :product_prices, :upgrade, :boolean
  end

  def self.down
    remove_column :product_prices, :upgrade
  end
end
