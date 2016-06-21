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

ActiveRecord::Schema.define(version: 20160608031051) do

  create_table "appointments", force: :cascade do |t|
    t.integer  "teacher_id",      limit: 4
    t.integer  "section",         limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "start"
    t.datetime "end"
    t.integer  "user_id",         limit: 4
    t.string   "appointment_url", limit: 255
  end

  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "available_sections", force: :cascade do |t|
    t.integer  "teacher_id",     limit: 4
    t.integer  "appointment_id", limit: 4
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.integer  "teacher_id", limit: 4
    t.string   "name",       limit: 255
    t.string   "score",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "educations", force: :cascade do |t|
    t.integer  "teacher_id", limit: 4
    t.string   "school",     limit: 255
    t.text     "major",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "start",      limit: 255
    t.string   "end",        limit: 255
  end

  create_table "evaluations", force: :cascade do |t|
    t.string   "comment",          limit: 255
    t.integer  "rating",           limit: 4,   default: 5
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "appointment_id",   limit: 4
    t.integer  "evaluatable_id",   limit: 4
    t.string   "evaluatable_type", limit: 255
    t.integer  "evaluated_id",     limit: 4
  end

  add_index "evaluations", ["appointment_id"], name: "index_evaluations_on_appointment_id", using: :btree
  add_index "evaluations", ["evaluatable_id"], name: "index_evaluations_on_evaluatable_id", using: :btree
  add_index "evaluations", ["evaluated_id"], name: "index_evaluations_on_evaluated_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.integer  "teacher_id",   limit: 4
    t.string   "company_name", limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "start",        limit: 255
    t.string   "end",          limit: 255
    t.string   "position",     limit: 255
  end

  create_table "languages", force: :cascade do |t|
    t.string   "language",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "friend_id",  limit: 4
    t.text     "message",    limit: 65535
    t.string   "problem",    limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.integer  "teacher_id",            limit: 4
    t.integer  "section",               limit: 4
    t.integer  "amount",                limit: 4
    t.string   "status",                limit: 255
    t.string   "payment_status",        limit: 255
    t.string   "attendance_status",     limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.boolean  "paid",                                default: false
    t.string   "email",                 limit: 255
    t.string   "session",               limit: 255
    t.datetime "paid_at"
    t.string   "paypal_status",         limit: 255
    t.string   "paypal_transaction_id", limit: 255
    t.text     "paypal_params",         limit: 65535
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id",       limit: 4
    t.string   "payment_method", limit: 255
    t.integer  "amount",         limit: 4
    t.boolean  "paid",                         default: false
    t.text     "params",         limit: 65535
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree

  create_table "remarks", force: :cascade do |t|
    t.integer  "teacher_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "desciption", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "scholarships", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "new_user_id", limit: 4
    t.string   "bonus",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "second_tongues", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "language",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teacher_languageships", force: :cascade do |t|
    t.integer  "teacher_id",  limit: 4
    t.integer  "language_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "youtube",       limit: 255
    t.text     "introduction",  limit: 65535
    t.integer  "trial_fee",     limit: 4
    t.integer  "one_fee",       limit: 4
    t.integer  "five_fee",      limit: 4
    t.integer  "ten_fee",       limit: 4
    t.string   "gathering_way", limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "avg_rating",    limit: 4,     default: 0
    t.string   "check",         limit: 255
    t.string   "hangouts_url",  limit: 255
  end

  create_table "user_available_sections", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.integer  "teacher_id",        limit: 4
    t.integer  "available_section", limit: 4, default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "trailed",                     default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "username",               limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "location",               limit: 255
    t.string   "currency",               limit: 255,   default: "USD"
    t.string   "tongue",                 limit: 255
    t.string   "born_form",              limit: 255
    t.string   "live_in",                limit: 255
    t.boolean  "gender"
    t.string   "time_zone",              limit: 255
    t.integer  "user_id",                limit: 4
    t.datetime "birthday"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "fb_uid",                 limit: 255
    t.string   "fb_token",               limit: 255
    t.text     "fb_raw_data",            limit: 65535
    t.string   "google_uid",             limit: 255
    t.string   "google_token",           limit: 255
    t.text     "google_raw_data",        limit: 65535
    t.string   "locale",                 limit: 255
    t.string   "authority",              limit: 255
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.integer  "image_file_size",        limit: 4
    t.datetime "image_updated_at"
    t.string   "authentication_token",   limit: 255
    t.boolean  "admin_by_lululala"
    t.string   "fb_pic",                 limit: 255
    t.string   "google_pic",             limit: 255
    t.string   "alternate_email",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["google_uid"], name: "index_users_on_google_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_id"], name: "index_users_on_user_id", using: :btree

end
