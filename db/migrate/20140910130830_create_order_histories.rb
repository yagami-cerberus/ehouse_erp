class CreateOrderHistories < ActiveRecord::Migration
  def change
    create_table :order_histories do |t|
      t.references :user, null: false
      t.references :order, null: false
      t.string :action, null: false, limit: 32
      t.hstore :data, null: true
      t.text :message, null: true
      t.datetime :created_at, :null => false
    end
  end
end
