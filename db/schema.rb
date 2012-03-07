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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120307051239) do

  create_table "fields", :force => true do |t|
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "unique_id"
    t.integer  "schedule_id"
    t.integer  "field_id"
    t.datetime "start_time"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.boolean  "canceled",     :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "version"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
