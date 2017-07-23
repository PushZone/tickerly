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

ActiveRecord::Schema.define(version: 20170518164312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crime_approves", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "crime_id"
    t.string "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crime_unapproves", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "crime_id"
    t.string "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crimes", id: :serial, force: :cascade do |t|
    t.string "user_name"
    t.string "crime_type"
    t.string "user_email"
    t.string "lat"
    t.string "lon"
    t.string "location_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.text "desc"
    t.integer "verified", default: 0
    t.integer "unapprove", default: 0
    t.string "created_by"
    t.string "crime_name"
    t.string "crime_image_link"
  end

  create_table "iplists", id: :serial, force: :cascade do |t|
    t.string "ip"
    t.integer "count", default: 0
    t.string "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_discounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "store_id"
    t.string "discount"
    t.integer "point"
    t.string "description"
    t.integer "used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "lat"
    t.string "lon"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_activities", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "crime_id"
    t.integer "activity_type"
    t.integer "point"
    t.string "crime_type"
    t.string "lat"
    t.string "lon"
    t.string "location_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_items", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "store_discount_id"
    t.boolean "used", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_route_histories", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "lat"
    t.string "lon"
    t.string "place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "useremails", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "password"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "userid"
    t.string "useremail"
    t.string "usergender"
    t.string "userbirthday"
    t.string "userpic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "userid", limit: 8
    t.string "useremail"
    t.string "usergender"
    t.string "userbirthday"
    t.string "userpic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point", default: 0
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
