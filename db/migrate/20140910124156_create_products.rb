class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :manufacturer, null: false, limit: 256
      t.string :model_id, null: false, limit: 256
      t.decimal :price, null: true
      t.string :color, null: true
      
      t.decimal :width, null: true
      t.decimal :depth, null: true
      t.decimal :height, null: true
      
      t.hstore :metadata, null: false, default: {}
      
      t.boolean :archived, null: false, default: false
      t.text :summary, null: true
      
      t.timestamps
    end
  end
end
