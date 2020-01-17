# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_17_195556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "build_perks", id: :serial, force: :cascade do |t|
    t.string "perk_name"
    t.string "build_name"
    t.integer "build_id"
    t.integer "perk_id"
  end

  create_table "builds", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "character_id"
    t.string "build_type"
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "bio"
    t.string "overview"
    t.string "character_type"
    t.string "build_id"
  end

  create_table "perks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "character"
    t.string "role"
    t.integer "count"
    t.string "raw_html"
    t.integer "build_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
