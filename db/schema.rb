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

ActiveRecord::Schema.define(version: 2019_07_12_124229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "image"
    t.string "user_type", limit: 1
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.boolean "unregistered", default: false
    t.string "unregister_token"
    t.datetime "unregister_send_at"
    t.string "update_token"
    t.datetime "update_send_at"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_contacts_on_institution_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "initials"
    t.string "color"
    t.datetime "beginning_date"
    t.datetime "end_date"
    t.string "local"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_institutions_on_city_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "researchers", force: :cascade do |t|
    t.string "name"
    t.string "gender", limit: 1
    t.string "image"
    t.bigint "scholarity_id"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_researchers_on_institution_id"
    t.index ["scholarity_id"], name: "index_researchers_on_scholarity_id"
  end

  create_table "scholarities", force: :cascade do |t|
    t.string "name"
    t.string "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "sections" because of following StandardError
#   Unknown type 'section_statuses' for column 'status'

  create_table "sponsor_events", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_sponsor_events_on_event_id"
    t.index ["institution_id"], name: "index_sponsor_events_on_institution_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "acronym"
    t.string "name"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_states_on_region_id"
  end

  add_foreign_key "cities", "states"
  add_foreign_key "contacts", "institutions"
  add_foreign_key "institutions", "cities"
  add_foreign_key "researchers", "institutions"
  add_foreign_key "researchers", "scholarities"
  add_foreign_key "states", "regions"
end
