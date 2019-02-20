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

ActiveRecord::Schema.define(version: 20190220023828) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "faculties", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username",                               null: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.text     "id_card_data"
    t.string   "weblink",                                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",               default: false, null: false
  end

  add_index "faculties", ["approved"], name: "index_faculties_on_approved"
  add_index "faculties", ["confirmation_token"], name: "index_faculties_on_confirmation_token", unique: true
  add_index "faculties", ["email"], name: "index_faculties_on_email", unique: true
  add_index "faculties", ["reset_password_token"], name: "index_faculties_on_reset_password_token", unique: true
  add_index "faculties", ["username"], name: "index_faculties_on_username", unique: true

  create_table "profiles", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "gre"
    t.integer  "toefl"
    t.decimal  "cgpa"
    t.string   "interested_major"
    t.string   "interested_term"
    t.integer  "interested_year"
    t.integer  "year_work_exp"
    t.integer  "month_work_exp"
    t.text     "resume_data"
    t.text     "sop_data"
    t.text     "additional_attachment"
  end

  add_index "profiles", ["student_id"], name: "index_profiles_on_student_id"

  create_table "students", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",                            null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  add_index "students", ["username"], name: "index_students_on_username", unique: true

  create_table "universities", force: :cascade do |t|
    t.integer "rank"
    t.string  "university_name"
    t.string  "university_type"
    t.float   "acceptance_rate"
    t.string  "tuition"
    t.string  "location"
    t.string  "weather"
    t.string  "university_link"
    t.string  "university_desc"
  end

  add_index "universities", ["university_name"], name: "index_universities_on_university_name", unique: true

end
