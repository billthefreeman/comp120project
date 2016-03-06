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

ActiveRecord::Schema.define(version: 20160306450949) do

  create_table "cates", force: :cascade do |t|
    t.string   "cate_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "department_name", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "group_name",    limit: 255
    t.integer  "department_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.string   "location",               limit: 255
    t.integer  "status_id",              limit: 4,   default: 1
    t.datetime "closed_date_time"
    t.datetime "processed_date_time"
    t.datetime "solved_date_time"
    t.integer  "severity",               limit: 4
    t.integer  "cate_id",                limit: 4
    t.string   "other_cate_description", limit: 255
    t.string   "incident_description",   limit: 255
    t.integer  "reporter_id",            limit: 4
    t.integer  "assignee_id",            limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "cover_file_name",        limit: 255
    t.string   "cover_content_type",     limit: 255
    t.integer  "cover_file_size",        limit: 4
    t.datetime "cover_updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "user_name",    limit: 255
    t.string   "phone",        limit: 255
    t.string   "second_phone", limit: 255
    t.string   "email",        limit: 255
    t.string   "pw",           limit: 255
    t.integer  "group_id",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "status_name", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
