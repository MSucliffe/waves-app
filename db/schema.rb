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

ActiveRecord::Schema.define(version: 20160901141804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "countries", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", using: :btree
  end

  create_table "customers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "vessel_id"
    t.string   "type"
    t.string   "email"
    t.string   "name"
    t.string   "nationality"
    t.string   "phone_number"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["email"], name: "index_customers_on_email", using: :btree
    t.index ["type"], name: "index_customers_on_type", using: :btree
    t.index ["vessel_id"], name: "index_customers_on_vessel_id", using: :btree
  end

  create_table "declarations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "submission_id"
    t.string   "state"
    t.string   "owner_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.uuid     "notification_id"
    t.index ["notification_id"], name: "index_declarations_on_notification_id", using: :btree
    t.index ["state"], name: "index_declarations_on_state", using: :btree
    t.index ["submission_id"], name: "index_declarations_on_submission_id", using: :btree
  end

  create_table "notes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "noteable_id"
    t.string   "noteable_type"
    t.uuid     "actioned_by_id"
    t.string   "type"
    t.string   "subject"
    t.string   "format"
    t.datetime "noted_at"
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["actioned_by_id"], name: "index_notes_on_actioned_by_id", using: :btree
    t.index ["noteable_id"], name: "index_notes_on_noteable_id", using: :btree
    t.index ["noteable_type"], name: "index_notes_on_noteable_type", using: :btree
    t.index ["type"], name: "index_notes_on_type", using: :btree
  end

  create_table "notifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "submission_id"
    t.string   "type"
    t.string   "subject"
    t.text     "body"
    t.boolean  "delivered",      default: false
    t.uuid     "actioned_by_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["type"], name: "index_notifications_on_type", using: :btree
  end

  create_table "payments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "submission_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "wp_token"
    t.string   "wp_order_code"
    t.string   "wp_amount"
    t.string   "wp_country"
    t.string   "customer_ip"
    t.json     "wp_payment_response"
    t.index ["submission_id"], name: "index_payments_on_submission_id", using: :btree
  end

  create_table "registrations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "vessel_id"
    t.uuid     "submission_id"
    t.date     "registered_at"
    t.date     "registered_until"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.uuid     "actioned_by_id"
    t.index ["actioned_by_id"], name: "index_registrations_on_actioned_by_id", using: :btree
  end

  create_table "roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "target_date"
    t.boolean  "is_urgent"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.uuid     "delivery_address_id"
    t.json     "changeset"
    t.string   "part"
    t.string   "type"
    t.string   "state"
    t.uuid     "claimant_id"
    t.datetime "referred_until"
    t.string   "ref_no"
    t.index ["claimant_id"], name: "index_submissions_on_claimant_id", using: :btree
    t.index ["part"], name: "index_submissions_on_part", using: :btree
    t.index ["ref_no"], name: "index_submissions_on_ref_no", using: :btree
    t.index ["state"], name: "index_submissions_on_state", using: :btree
    t.index ["type"], name: "index_submissions_on_type", using: :btree
  end

  create_table "user_roles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "ldap_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "vessel_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "key"
  end

  create_table "vessels", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "hin"
    t.string   "make_and_model"
    t.integer  "number_of_hulls",  null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "mmsi_number",      null: false
    t.string   "radio_call_sign",  null: false
    t.string   "vessel_type"
    t.decimal  "length_in_meters"
  end

end
