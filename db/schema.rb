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

ActiveRecord::Schema.define(version: 20150213131226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoptions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id", null: false
    t.integer  "user_id",    null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "contributions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "city"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "abstract"
    t.integer  "category_id",                null: false
    t.integer  "organization_id",            null: false
    t.string   "google_drive_url",           null: false
    t.string   "google_drive_embed",         null: false
    t.datetime "closes_for_contribution_at", null: false
    t.string   "facebook_share_title"
    t.text     "facebook_share_description"
    t.string   "facebook_share_image"
    t.text     "twitter_share_message"
    t.string   "legislative_chamber"
    t.text     "legislative_processing"
    t.text     "email_to_contributor"
    t.text     "email_to_signer"
    t.text     "taf_message"
    t.integer  "user_id",                    null: false
    t.string   "image",                      null: false
    t.datetime "accepted_at"
    t.datetime "rejected_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.string   "cas_ticket"
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
    t.string  "email"
    t.string  "avatar"
    t.string  "first_name"
    t.string  "last_name"
    t.boolean "admin"
  end

  add_foreign_key "adoptions", "projects"
  add_foreign_key "contributions", "projects"
  add_foreign_key "projects", "categories"
  add_foreign_key "signatures", "projects"
end
