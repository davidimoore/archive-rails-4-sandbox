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

ActiveRecord::Schema.define(version: 20170123184450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "minions", force: :cascade do |t|
    t.integer  "thing_id"
    t.integer  "user_id"
    t.string   "mcol0"
    t.string   "mcol1"
    t.string   "mcol2"
    t.string   "mcol3"
    t.string   "mcol4"
    t.string   "mcol5"
    t.string   "mcol6"
    t.string   "mcol7"
    t.string   "mcol8"
    t.string   "mcol9"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "things", force: :cascade do |t|
    t.string   "col0"
    t.string   "col1"
    t.string   "col2"
    t.string   "col3"
    t.string   "col4"
    t.string   "col5"
    t.string   "col6"
    t.string   "col7"
    t.string   "col8"
    t.string   "col9"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "minions_count", default: 0, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "minions", "users"
end
