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

ActiveRecord::Schema.define(version: 20170423071702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_customers", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "customer_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "code"
    t.boolean  "sms_status",  default: false, null: false
    t.boolean  "gift_status", default: false, null: false
    t.boolean  "code_status", default: false, null: false
    t.index ["campaign_id"], name: "index_campaign_customers_on_campaign_id", using: :btree
    t.index ["customer_id"], name: "index_campaign_customers_on_customer_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",                      null: false
    t.text     "content"
    t.datetime "start_time",                null: false
    t.datetime "end_time",                  null: false
    t.string   "location",                  null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "product_count", default: 0, null: false
    t.integer  "product_id"
    t.index ["product_id"], name: "index_campaigns_on_product_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "phone",      null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_customers_on_phone", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                     null: false
    t.string   "code",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "price",      default: 0.0, null: false
    t.string   "unit",                     null: false
    t.index ["code"], name: "index_products_on_code", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "email",                       null: false
    t.string   "password_digest",             null: false
    t.integer  "level",           default: 2, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "campaign_customers", "campaigns"
  add_foreign_key "campaign_customers", "customers"
  add_foreign_key "campaigns", "products"
end
