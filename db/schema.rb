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

ActiveRecord::Schema.define(version: 20140729215650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collectives", force: true do |t|
    t.integer  "territory_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gold_standard_identities", force: true do |t|
    t.integer  "household_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "alternate_name"
    t.string   "sex"
    t.date     "date_of_birth"
    t.integer  "village_id"
    t.integer  "group_id"
    t.integer  "collective_id"
    t.integer  "territory_id"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recorded_by"
    t.string   "alternate_village"
    t.string   "village_of_origin"
    t.string   "head_of_household_first_name"
    t.string   "head_of_household_last_name"
    t.string   "relation_to_head_of_household"
    t.integer  "household_size"
    t.date     "arrival_date"
    t.string   "arrival_from_village"
    t.string   "recorded_in_village"
    t.string   "nick_name"
    t.string   "other_first_name"
    t.string   "other_last_name"
    t.string   "other_alternate_name"
    t.string   "head_of_household_alternate_name"
    t.string   "head_of_household_two_first_name"
    t.string   "head_of_household_two_last_name"
    t.string   "head_of_household_two_alternate_name"
    t.string   "relation_to_head_of_household_two"
    t.string   "identity_card"
    t.string   "iom_identity_card"
    t.string   "arrival_from_type"
  end

  add_index "gold_standard_identities", ["first_name"], name: "index_gold_standard_identities_on_first_name", using: :btree
  add_index "gold_standard_identities", ["household_id"], name: "index_gold_standard_identities_on_household_id", using: :btree
  add_index "gold_standard_identities", ["last_name"], name: "index_gold_standard_identities_on_last_name", using: :btree

  create_table "gold_standard_matches", force: true do |t|
    t.integer  "gold_standard_identity_id"
    t.integer  "iom_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gold_standard_matches", ["gold_standard_identity_id"], name: "index_gold_standard_matches_on_gold_standard_identity_id", using: :btree
  add_index "gold_standard_matches", ["iom_identity_id"], name: "index_gold_standard_matches_on_iom_identity_id", using: :btree

  create_table "groups", force: true do |t|
    t.integer  "collective_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "households", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "idp_trajectories", force: true do |t|
    t.integer  "gold_standard_identity_id"
    t.integer  "stop_number"
    t.string   "mode_of_transport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recorded_by"
    t.string   "recorded_in_village"
    t.integer  "village_id"
    t.integer  "group_id"
    t.integer  "collective_id"
    t.integer  "territory_id"
    t.integer  "province_id"
    t.string   "alternate_village"
    t.string   "stop_type"
    t.string   "arrival_from_type"
    t.string   "site_id"
    t.date     "departure_date"
  end

  add_index "idp_trajectories", ["gold_standard_identity_id"], name: "index_idp_trajectories_on_gold_standard_identity_id", using: :btree

  create_table "iom_identities", force: true do |t|
    t.integer  "household_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "alternate_name"
    t.string   "sex"
    t.date     "date_of_birth"
    t.integer  "village_id"
    t.integer  "group_id"
    t.integer  "collective_id"
    t.integer  "territory_id"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alternate_village"
    t.string   "village_of_origin"
    t.string   "head_of_household_first_name"
    t.string   "head_of_household_last_name"
    t.string   "relation_to_head_of_household"
    t.integer  "household_size"
    t.date     "arrival_date"
    t.string   "arrival_from_village"
    t.string   "nick_name"
    t.string   "other_first_name"
    t.string   "other_last_name"
    t.string   "other_alternate_name"
    t.string   "head_of_household_alternate_name"
    t.string   "head_of_household_two_first_name"
    t.string   "head_of_household_two_last_name"
    t.string   "head_of_household_two_alternate_name"
    t.string   "relation_to_head_of_household_two"
    t.string   "identity_card"
    t.string   "iom_identity_card"
    t.string   "arrival_from_type"
  end

  add_index "iom_identities", ["first_name"], name: "index_iom_identities_on_first_name", using: :btree
  add_index "iom_identities", ["household_id"], name: "index_iom_identities_on_household_id", using: :btree
  add_index "iom_identities", ["last_name"], name: "index_iom_identities_on_last_name", using: :btree

  create_table "provinces", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "sites", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "territories", force: true do |t|
    t.integer  "province_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "computer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["computer"], name: "index_users_on_computer", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "villages", force: true do |t|
    t.integer  "group_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
