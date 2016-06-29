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

ActiveRecord::Schema.define(version: 20160629053301) do

  create_table "divisions", force: :cascade do |t|
    t.string   "descrition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "receiver"
    t.string   "status"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "positions", force: :cascade do |t|
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "division_id"
    t.integer  "skill_id"
    t.integer  "position_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "profiles", ["division_id"], name: "index_profiles_on_division_id"
  add_index "profiles", ["position_id"], name: "index_profiles_on_position_id"
  add_index "profiles", ["skill_id"], name: "index_profiles_on_skill_id"
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "report_date"
    t.string   "progress"
    t.string   "achievement"
    t.string   "next_day_plan"
    t.string   "comment_question"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "reports", ["user_id", "created_at"], name: "index_reports_on_user_id_and_created_at"
  add_index "reports", ["user_id"], name: "index_reports_on_user_id"

  create_table "requests", force: :cascade do |t|
    t.integer  "kind_of_leave"
    t.datetime "time_out"
    t.datetime "time_in"
    t.time     "time"
    t.string   "compensation_time"
    t.string   "reason"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "requests", ["user_id", "created_at"], name: "index_requests_on_user_id_and_created_at"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "skills", force: :cascade do |t|
    t.string   "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "birthday"
    t.integer  "gender"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.string   "remember_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
