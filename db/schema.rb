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

ActiveRecord::Schema.define(version: 20160414000115) do

  create_table "cates", force: :cascade do |t|
    t.string   "cate_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

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

  create_table "managers", force: :cascade do |t|
    t.string   "email",              limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body",            limit: 65535
    t.integer  "conversation_id", limit: 4
    t.integer  "person_id",       limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["person_id"], name: "index_messages_on_person_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "user_name",          limit: 255
    t.string   "phone",              limit: 255
    t.string   "second_phone",       limit: 255
    t.string   "email",              limit: 255
    t.integer  "group_id",           limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "pw",                 limit: 255
    t.string   "encrypted_password", limit: 255, default: "", null: false
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "status_name", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "people"
end
