class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, null: false, limit: 64
      t.string :hashed_password, null: false, limit: 128
      t.string :nickname, null: false, limit: 128
      t.string :email, null: true, limit: 128
      
      t.boolean :superuser, null: false, default: false
      t.boolean :disabled, null: false, default: false
      
      t.datetime :lastlogin_at, null: true
      t.timestamps
    end
  end
end
