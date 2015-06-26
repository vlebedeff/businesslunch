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

ActiveRecord::Schema.define(version: 20150626070455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",                  null: false
    t.string   "action",       limit: 255, null: false
    t.integer  "subject_id",               null: false
    t.string   "subject_type", limit: 255, null: false
    t.string   "data",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["subject_id", "subject_type"], name: "index_activities_on_subject_id_and_subject_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "freezes", force: :cascade do |t|
    t.date     "frozen_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  add_index "freezes", ["frozen_on"], name: "index_freezes_on_frozen_on", using: :btree
  add_index "freezes", ["group_id"], name: "index_freezes_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree

  create_table "menu_sets", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.text     "details"
    t.date     "available_on",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",                                     null: false
    t.integer  "menu_set_id",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",       limit: 255, default: "pending"
    t.date     "created_on"
    t.integer  "group_id"
  end

  add_index "orders", ["created_on"], name: "index_orders_on_created_on", using: :btree
  add_index "orders", ["group_id"], name: "index_orders_on_group_id", using: :btree
  add_index "orders", ["menu_set_id"], name: "index_orders_on_menu_set_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id",                                          null: false
    t.integer  "group_id",                                         null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.decimal  "balance",    precision: 8, scale: 2, default: 0.0
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles"
    t.integer  "balance",                            default: 0
    t.integer  "current_group_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["current_group_id"], name: "index_users_on_current_group_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["roles"], name: "index_users_on_roles", using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vendors", ["name"], name: "index_vendors_on_name", unique: true, using: :btree

  add_foreign_key "freezes", "groups"
  add_foreign_key "orders", "groups"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
