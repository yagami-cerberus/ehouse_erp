class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :created_by, null: false
      t.integer :status_flags, null: false, :default => 0
      t.text :summary, null: false
      t.timestamps
    end
  end
end
