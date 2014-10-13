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

ActiveRecord::Schema.define(version: 20141013112753) do

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "studio"
    t.integer  "rotten"
    t.integer  "audience"
    t.string   "story"
    t.string   "genre"
    t.integer  "numtheatres"
    t.integer  "boxaverage"
    t.decimal  "domesticgross",  precision: 10, scale: 3
    t.decimal  "foreigngross",   precision: 10, scale: 3
    t.decimal  "worldwidegross", precision: 10, scale: 3
    t.decimal  "budget",         precision: 10, scale: 3
    t.decimal  "profitability",  precision: 10, scale: 6
    t.decimal  "openingweekend", precision: 10, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
