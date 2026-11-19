# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_19_191420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "carpets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.string "category"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "phone"
    t.text "message"
    t.text "admin_reply"
    t.datetime "replied_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "carpet_id", null: false
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpet_id"], name: "index_order_items_on_carpet_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "customer_name"
    t.string "phone"
    t.text "address"
    t.decimal "total_price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_status"
    t.string "delivery_method"
    t.string "payment_method"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "carpet_id", null: false
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpet_id"], name: "index_reviews_on_carpet_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "feedbacks", "users"
  add_foreign_key "order_items", "carpets"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "carpets"
  add_foreign_key "reviews", "users"
  add_foreign_key "sessions", "users"
end
