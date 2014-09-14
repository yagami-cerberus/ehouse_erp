class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.references :product, null: false
      t.references :order, null: false
      t.integer :quantity, null: false
    end
  end
end
