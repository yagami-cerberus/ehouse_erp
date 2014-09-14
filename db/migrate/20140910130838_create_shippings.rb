class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.references :order
      t.references :created_by, null: false
      t.integer :status_flags, null: false, default: 0
      t.timestamps
    end
  end
end
