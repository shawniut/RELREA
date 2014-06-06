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

ActiveRecord::Schema.define(version: 20140606074023) do

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
  end

  create_table "infos", force: true do |t|
    t.string   "project_id"
    t.date     "next_release_date"
    t.date     "start_date"
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
  end

  create_table "rattributes", force: true do |t|
    t.string   "project_id"
    t.string   "name"
    t.float    "value"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "metric_id"
    t.string   "mfunction_id"
    t.float    "weight"
  end

  create_table "releases", force: true do |t|
    t.string   "project_id"
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "values", force: true do |t|
    t.string   "rattribute_id"
    t.float    "mvalue"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
