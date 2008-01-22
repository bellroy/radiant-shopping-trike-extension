class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :code, :string
      t.column :description, :string
      t.column :price, :decimal, :precision => 8, :scale => 2, :default => 0
    end
  end

  def self.down
    drop_table :products
  end
end