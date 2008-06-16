class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.column :code, :string
      t.column :product_id, :integer
      t.column :expiration_date, :date
      t.column :discount_per_order, :decimal, :precision => 8, :scale => 2, :default => 0
    end
  end

  def self.down
    drop_table :coupons
  end
end
