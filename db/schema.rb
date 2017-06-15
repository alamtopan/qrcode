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

ActiveRecord::Schema.define(version: 20170615153620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "confirmations", force: :cascade do |t|
    t.string   "invoice_code"
    t.integer  "user_id"
    t.integer  "course_id"
    t.date     "payment_date"
    t.integer  "nominal"
    t.string   "bank_account"
    t.string   "payment_method"
    t.string   "sender_name"
    t.string   "status",         default: "pending"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "confirmations", ["course_id"], name: "index_confirmations_on_course_id", using: :btree
  add_index "confirmations", ["user_id"], name: "index_confirmations_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "name"
    t.string   "schedule"
    t.string   "status",      default: "pending"
    t.integer  "price",       default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "result_test", default: 0
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "slug"
    t.string   "type"
    t.string   "photo"
    t.string   "status",                 default: "pending"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "born"
    t.string   "gender"
    t.text     "address"
    t.string   "phone"
    t.string   "parent_name"
    t.string   "parent_address"
    t.string   "parent_contact"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
