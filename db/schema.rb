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

  create_table "minions", force: :cascade do |t|
    t.integer  "thing_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "mcol0",      limit: 255
    t.string   "mcol1",      limit: 255
    t.string   "mcol2",      limit: 255
    t.string   "mcol3",      limit: 255
    t.string   "mcol4",      limit: 255
    t.string   "mcol5",      limit: 255
    t.string   "mcol6",      limit: 255
    t.string   "mcol7",      limit: 255
    t.string   "mcol8",      limit: 255
    t.string   "mcol9",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "minions", ["user_id"], name: "fk_rails_4cc30354f5", using: :btree

  create_table "things", force: :cascade do |t|
    t.string   "col0",       limit: 255
    t.string   "col1",       limit: 255
    t.string   "col2",       limit: 255
    t.string   "col3",       limit: 255
    t.string   "col4",       limit: 255
    t.string   "col5",       limit: 255
    t.string   "col6",       limit: 255
    t.string   "col7",       limit: 255
    t.string   "col8",       limit: 255
    t.string   "col9",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",    limit: 255
    t.string   "last_name",     limit: 255
    t.string   "email",         limit: 255
    t.integer  "minions_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_foreign_key "minions", "users"
end
