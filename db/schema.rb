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

ActiveRecord::Schema.define(version: 20170830033419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.string "description"
    t.string "api_key"
    t.integer "facts_count", default: 0
    t.datetime "last_seen", default: "2017-08-30 04:31:43"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_clients_on_uuid"
  end

  create_table "facts", force: :cascade do |t|
    t.string "full_text"
    t.boolean "microdata", default: false
    t.string "source_url"
    t.string "client_uuid"
    t.integer "site_id"
    t.datetime "last_seen", default: "2017-08-30 04:31:43"
    t.integer "times_seen", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date_published"
    t.string "url"
    t.string "claim_reviewed"
    t.string "author_type"
    t.string "author_url"
    t.string "author_image"
    t.string "author_same_as"
    t.string "review_type"
    t.string "review_rating_value"
    t.string "review_best_rating"
    t.string "review_image"
    t.string "review_alternate_name"
    t.string "item_reviewed_type"
    t.datetime "item_reviewed_date_published"
    t.string "item_reviewed_name"
    t.string "item_reviewed_author_type"
    t.string "item_reviewed_author_name"
    t.string "item_reviewed_author_job_title"
    t.string "item_reviewed_author_image"
    t.string "item_reviewed_author_same_as"
    t.index ["source_url"], name: "index_facts_on_source_url"
  end

  create_table "sites", force: :cascade do |t|
    t.string "base_url"
    t.datetime "last_visted", default: "2017-08-30 04:31:43"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
