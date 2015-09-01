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

ActiveRecord::Schema.define(version: 20150901210726) do

  create_table "emails", force: :cascade do |t|
    t.string   "email"
    t.string   "note"
    t.integer  "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "emails", ["library_id"], name: "index_emails_on_library_id"

  create_table "faxes", force: :cascade do |t|
    t.string   "fax"
    t.integer  "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "faxes", ["library_id"], name: "index_faxes_on_library_id"

  create_table "libraries", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "city"
    t.string   "street"
    t.string   "zip"
    t.string   "description"
    t.string   "sigla"
    t.string   "district"
    t.string   "town"
    t.string   "context"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "longitude"
    t.float    "latitude"
  end

  add_index "libraries", ["name"], name: "index_libraries_on_name"
  add_index "libraries", ["sigla"], name: "index_libraries_on_sigla"

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "degree1"
    t.string   "degree2"
    t.string   "role"
    t.string   "addressing"
    t.integer  "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "people", ["library_id"], name: "index_people_on_library_id"

  create_table "phones", force: :cascade do |t|
    t.string   "phone"
    t.integer  "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "phones", ["library_id"], name: "index_phones_on_library_id"

  create_table "websites", force: :cascade do |t|
    t.string   "url"
    t.string   "note"
    t.integer  "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "websites", ["library_id"], name: "index_websites_on_library_id"

end
