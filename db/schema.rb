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

ActiveRecord::Schema.define(version: 20150129125755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "closed_for_contribution_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.string   "cas_ticket", limit: 255
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["cas_ticket"], name: "index_sessions_on_cas_ticket", using: :btree
  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "signatures", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string  "email",      limit: 255
    t.string  "avatar",     limit: 255
    t.string  "first_name", limit: 255
    t.string  "last_name",  limit: 255
    t.boolean "admin"
  end

  add_foreign_key "signatures", "projects"
end
