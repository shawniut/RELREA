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

ActiveRecord::Schema.define(version: 20140621231308) do

  create_table "criteria", force: true do |t|
    t.string   "name"
    t.float    "value"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dataservice_metrics", force: true do |t|
    t.string   "name"
    t.string   "source"
    t.string   "dimension"
    t.string   "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rattribute_id"
    t.string   "code"
  end

  create_table "infos", force: true do |t|
    t.integer  "project_id",        limit: 255
    t.date     "next_release_date"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_private"
  end

  create_table "jiras", force: true do |t|
    t.string   "url"
    t.string   "username"
    t.string   "password"
    t.string   "project_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "metrics", force: true do |t|
    t.string   "name"
    t.string   "source"
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mfunctions", force: true do |t|
    t.string   "name"
    t.string   "parameter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "repo"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.string   "username"
    t.string   "password"
  end

  create_table "rattributes", force: true do |t|
    t.integer  "project_id",   limit: 255
    t.string   "name"
    t.float    "value"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "metric_id",    limit: 255
    t.integer  "mfunction_id", limit: 255
    t.float    "weight"
    t.string   "label"
    t.integer  "raw_file_id",  limit: 255
  end

  create_table "raw_files", force: true do |t|
    t.integer  "rattribute_id", limit: 255
    t.text     "file",          limit: 255
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", force: true do |t|
    t.integer  "project_id", limit: 255
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
  end

  create_table "values", force: true do |t|
    t.integer  "rattribute_id", limit: 255
    t.float    "mvalue"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
