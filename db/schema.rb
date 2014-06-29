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

ActiveRecord::Schema.define(version: 20140629055215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reconciled_matches", force: true do |t|
    t.integer  "master_dataset_id"
    t.string   "satellite_dataset"
    t.integer  "satellite_dataset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reconciled_matches", ["master_dataset_id"], name: "index_reconciled_matches_on_master_dataset_id", using: :btree
  add_index "reconciled_matches", ["satellite_dataset"], name: "index_reconciled_matches_on_satellite_dataset", using: :btree
  add_index "reconciled_matches", ["satellite_dataset_id"], name: "index_reconciled_matches_on_satellite_dataset_id", using: :btree

  create_table "test_idps", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex"
    t.string   "village"
  end

  add_index "test_idps", ["age"], name: "index_test_idps_on_age", using: :btree
  add_index "test_idps", ["first_name"], name: "index_test_idps_on_first_name", using: :btree
  add_index "test_idps", ["last_name"], name: "index_test_idps_on_last_name", using: :btree

  create_table "unreconciled_matches", force: true do |t|
    t.string   "master_dataset_ids"
    t.string   "satellite_dataset"
    t.integer  "satellite_dataset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unreconciled_matches", ["satellite_dataset"], name: "index_unreconciled_matches_on_satellite_dataset", using: :btree
  add_index "unreconciled_matches", ["satellite_dataset_id"], name: "index_unreconciled_matches_on_satellite_dataset_id", using: :btree

end
