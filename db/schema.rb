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

ActiveRecord::Schema.define(version: 20191217195556) do

  create_table "build_perks", force: :cascade do |t|
    t.string  "perk_name"
    t.string  "build_name"
    t.integer "build_id"
    t.integer "perk_id"
  end

  create_table "builds", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
    t.integer "character_id"
    t.string  "build_type"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "bio"
    t.string "character_type"
    t.string "build_id"
  end

  create_table "perks", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.string  "character"
    t.string  "role"
    t.integer "count"
    t.string  "raw_html"
    t.integer "build_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
