# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140910130953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "order_histories", force: true do |t|
    t.integer  "user_id",               null: false
    t.integer  "order_id",              null: false
    t.string   "action",     limit: 32, null: false
    t.hstore   "data"
    t.text     "message"
    t.datetime "created_at",            null: false
  end

  create_table "order_products", force: true do |t|
    t.integer "product_id", null: false
    t.integer "order_id",   null: false
    t.integer "quantity",   null: false
  end

  create_table "orders", force: true do |t|
    t.integer  "created_by_id",             null: false
    t.integer  "status_flags",  default: 0, null: false
    t.text     "summary",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "manufacturer", limit: 256,                 null: false
    t.string   "model_id",     limit: 256,                 null: false
    t.decimal  "price"
    t.string   "color"
    t.decimal  "width"
    t.decimal  "depth"
    t.decimal  "height"
    t.hstore   "metadata",                 default: {},    null: false
    t.boolean  "archived",                 default: false, null: false
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_products", force: true do |t|
    t.integer "product_id",  null: false
    t.integer "shipping_id", null: false
    t.integer "quantity",    null: false
  end

  create_table "shippings", force: true do |t|
    t.integer  "order_id"
    t.integer  "created_by_id",             null: false
    t.integer  "status_flags",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login",           limit: 64,                  null: false
    t.string   "hashed_password", limit: 128,                 null: false
    t.string   "nickname",        limit: 128,                 null: false
    t.string   "email",           limit: 128
    t.boolean  "superuser",                   default: false, null: false
    t.boolean  "disabled",                    default: false, null: false
    t.datetime "lastlogin_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
