class CreateShippingProducts < ActiveRecord::Migration
  def change
    create_table :shipping_products do |t|
      t.references :product, null: false
      t.references :shipping, null: false
      t.integer :quantity, null: false
    end
  end
end
