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

ActiveRecord::Schema.define(version: 20160526054951) do

  create_table "appointments", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "section"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "start"
    t.datetime "end"
    t.integer  "user_id"
    t.string   "appointment_url"
  end

  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id"

  create_table "available_sections", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "appointment_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.integer  "teacher_id"
    t.string   "name"
    t.string   "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educations", force: :cascade do |t|
    t.integer  "teacher_id"
    t.string   "school"
    t.string   "major"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.string   "comment"
    t.integer  "rating",           default: 5
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "appointment_id"
    t.integer  "evaluatable_id"
    t.string   "evaluatable_type"
    t.integer  "evaluated_id"
  end

  add_index "evaluations", ["appointment_id"], name: "index_evaluations_on_appointment_id"
  add_index "evaluations", ["evaluatable_id"], name: "index_evaluations_on_evaluatable_id"
  add_index "evaluations", ["evaluated_id"], name: "index_evaluations_on_evaluated_id"

  create_table "experiences", force: :cascade do |t|
    t.integer  "teacher_id"
    t.string   "company_name"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "languages", force: :cascade do |t|
    t.integer  "teacher_id"
    t.string   "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.text     "message"
    t.string   "problem"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "teacher_id"
    t.integer  "section"
    t.integer  "amount"
    t.string   "status"
    t.string   "payment_status"
    t.string   "attendance_status"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "paid",                  default: false
    t.string   "email"
    t.string   "session"
    t.datetime "paid_at"
    t.string   "paypal_status"
    t.string   "paypal_transaction_id"
    t.text     "paypal_params"
  end

  create_table "payapl_payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "payment_method"
    t.integer  "amount"
    t.boolean  "paid",           default: false
    t.text     "params"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id"

  create_table "remarks", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "user_id"
    t.text     "desciption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scholarships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "new_user_id"
    t.string   "bonus"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "second_tongues", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_languageships", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "youtube"
    t.text     "introduction"
    t.integer  "trial_fee"
    t.integer  "one_fee"
    t.integer  "five_fee"
    t.integer  "ten_fee"
    t.string   "gathering_way"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "avg_rating",    default: 0
    t.string   "check"
    t.string   "hangouts_url"
  end

  create_table "user_available_sections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "teacher_id"
    t.integer  "available_section", default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "trailed",           default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.string   "currency"
    t.string   "tongue"
    t.string   "born_form"
    t.string   "live_in"
    t.boolean  "gender"
    t.string   "time_zone"
    t.integer  "user_id"
    t.datetime "birthday"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fb_uid"
    t.string   "fb_token"
    t.text     "fb_raw_data"
    t.string   "google_uid"
    t.string   "google_token"
    t.text     "google_raw_data"
    t.string   "locale"
    t.string   "authority"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "authentication_token"
    t.boolean  "admin"
    t.string   "fb_pic"
    t.string   "google_pic"

  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid"
  add_index "users", ["google_uid"], name: "index_users_on_google_uid"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["user_id"], name: "index_users_on_user_id"

end
