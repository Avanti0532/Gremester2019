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

ActiveRecord::Schema.define(version: 20190411041434) do

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

  create_table "applications", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "university_id"
    t.boolean  "applied"
    t.datetime "applied_date"
    t.boolean  "admitted"
    t.datetime "admitted_date"
    t.boolean  "rejected"
    t.datetime "rejected_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "term"
    t.integer  "year"
  end

  add_index "applications", ["profile_id"], name: "index_applications_on_profile_id"
  add_index "applications", ["university_id"], name: "index_applications_on_university_id"

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "countries", ["name"], name: "index_countries_on_name", unique: true

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
    t.integer  "university_id"
  end

  add_index "faculties", ["approved"], name: "index_faculties_on_approved"
  add_index "faculties", ["confirmation_token"], name: "index_faculties_on_confirmation_token", unique: true
  add_index "faculties", ["email"], name: "index_faculties_on_email", unique: true
  add_index "faculties", ["reset_password_token"], name: "index_faculties_on_reset_password_token", unique: true
  add_index "faculties", ["university_id"], name: "index_faculties_on_university_id"
  add_index "faculties", ["username"], name: "index_faculties_on_username", unique: true

  create_table "faculty_evaluations", force: :cascade do |t|
    t.integer  "faculty_id"
    t.integer  "application_id"
    t.integer  "score"
    t.integer  "ee_background"
    t.string   "comment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "faculty_evaluations", ["application_id"], name: "index_faculty_evaluations_on_application_id"
  add_index "faculty_evaluations", ["faculty_id"], name: "index_faculty_evaluations_on_faculty_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "grading_scale_types", force: :cascade do |t|
    t.string   "grading_scale_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "grading_scale_types", ["grading_scale_name"], name: "index_grading_scale_types_on_grading_scale_name", unique: true

  create_table "grading_scales", force: :cascade do |t|
    t.integer  "grading_scale_type_id"
    t.string   "letter_grade"
    t.decimal  "gpa"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "low_percent"
    t.integer  "high_percent"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "toefl"
    t.string   "interested_term"
    t.integer  "interested_year"
    t.text     "resume_data"
    t.text     "sop_data"
    t.text     "additional_attachment_data"
    t.integer  "gre_quant"
    t.decimal  "gre_writing"
    t.integer  "gre_verbal"
    t.integer  "country_id"
    t.text     "photo_id_data"
    t.integer  "degree_objective_phd"
    t.integer  "degree_objective_master"
    t.string   "gender"
    t.string   "year_work_exp"
  end

  add_index "profiles", ["country_id"], name: "index_profiles_on_country_id"
  add_index "profiles", ["student_id"], name: "index_profiles_on_student_id"

  create_table "profiles_undergrad_universities", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "undergrad_university_id"
    t.float   "cgpa"
    t.string  "degree_type"
    t.string  "major"
    t.integer "start_year"
    t.integer "end_year"
    t.integer "grading_scale_type_id"
  end

  add_index "profiles_undergrad_universities", ["grading_scale_type_id"], name: "index_profiles_undergrad_universities_on_grading_scale_type_id"

  create_table "rank_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rank_types", ["name"], name: "index_rank_types_on_name", unique: true

  create_table "rankings", force: :cascade do |t|
    t.integer  "rank_type_id"
    t.integer  "undergrad_university_id"
    t.integer  "rank"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "research_interests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "research_interests_profiles", force: :cascade do |t|
    t.integer "research_interest_id"
    t.integer "profile_id"
  end

  create_table "students", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username",                               null: false
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
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
    t.boolean  "isModerator",            default: false
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  add_index "students", ["username"], name: "index_students_on_username", unique: true

  create_table "thredded_categories", force: :cascade do |t|
    t.integer  "messageboard_id", null: false
    t.text     "name",            null: false
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "slug",            null: false
  end

  add_index "thredded_categories", ["messageboard_id", "slug"], name: "index_thredded_categories_on_messageboard_id_and_slug", unique: true
  add_index "thredded_categories", ["messageboard_id"], name: "index_thredded_categories_on_messageboard_id"
  add_index "thredded_categories", ["name"], name: "thredded_categories_name_ci"

  create_table "thredded_messageboard_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thredded_messageboard_notifications_for_followed_topics", force: :cascade do |t|
    t.integer "user_id",                                   null: false
    t.integer "messageboard_id",                           null: false
    t.string  "notifier_key",    limit: 90,                null: false
    t.boolean "enabled",                    default: true, null: false
  end

  add_index "thredded_messageboard_notifications_for_followed_topics", ["user_id", "messageboard_id", "notifier_key"], name: "thredded_messageboard_notifications_for_followed_topics_unique", unique: true

  create_table "thredded_messageboard_users", force: :cascade do |t|
    t.integer  "thredded_user_detail_id",  null: false
    t.integer  "thredded_messageboard_id", null: false
    t.datetime "last_seen_at",             null: false
  end

  add_index "thredded_messageboard_users", ["thredded_messageboard_id", "last_seen_at"], name: "index_thredded_messageboard_users_for_recently_active"
  add_index "thredded_messageboard_users", ["thredded_messageboard_id", "thredded_user_detail_id"], name: "index_thredded_messageboard_users_primary", unique: true

  create_table "thredded_messageboards", force: :cascade do |t|
    t.text     "name",                                  null: false
    t.text     "slug"
    t.text     "description"
    t.integer  "topics_count",          default: 0
    t.integer  "posts_count",           default: 0
    t.integer  "position",                              null: false
    t.integer  "last_topic_id"
    t.integer  "messageboard_group_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "locked",                default: false, null: false
  end

  add_index "thredded_messageboards", ["messageboard_group_id"], name: "index_thredded_messageboards_on_messageboard_group_id"
  add_index "thredded_messageboards", ["slug"], name: "index_thredded_messageboards_on_slug", unique: true

  create_table "thredded_notifications_for_followed_topics", force: :cascade do |t|
    t.integer "user_id",                                null: false
    t.string  "notifier_key", limit: 90,                null: false
    t.boolean "enabled",                 default: true, null: false
  end

  add_index "thredded_notifications_for_followed_topics", ["user_id", "notifier_key"], name: "thredded_notifications_for_followed_topics_unique", unique: true

  create_table "thredded_notifications_for_private_topics", force: :cascade do |t|
    t.integer "user_id",                                null: false
    t.string  "notifier_key", limit: 90,                null: false
    t.boolean "enabled",                 default: true, null: false
  end

  add_index "thredded_notifications_for_private_topics", ["user_id", "notifier_key"], name: "thredded_notifications_for_private_topics_unique", unique: true

  create_table "thredded_post_moderation_records", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "messageboard_id"
    t.text     "post_content",              limit: 65535
    t.integer  "post_user_id"
    t.text     "post_user_name"
    t.integer  "moderator_id"
    t.integer  "moderation_state",                        null: false
    t.integer  "previous_moderation_state",               null: false
    t.datetime "created_at",                              null: false
  end

  add_index "thredded_post_moderation_records", ["messageboard_id", "created_at"], name: "index_thredded_moderation_records_for_display"

  create_table "thredded_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content",          limit: 65535
    t.string   "source",           limit: 191,   default: "web"
    t.integer  "postable_id",                                    null: false
    t.integer  "messageboard_id",                                null: false
    t.integer  "moderation_state",                               null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "thredded_posts", ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id"
  add_index "thredded_posts", ["moderation_state", "updated_at"], name: "index_thredded_posts_for_display"
  add_index "thredded_posts", ["postable_id", "created_at"], name: "index_thredded_posts_on_postable_id_and_created_at"
  add_index "thredded_posts", ["postable_id"], name: "index_thredded_posts_on_postable_id"
  add_index "thredded_posts", ["user_id"], name: "index_thredded_posts_on_user_id"

  create_table "thredded_private_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content",     limit: 65535
    t.integer  "postable_id",               null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "thredded_private_posts", ["postable_id", "created_at"], name: "index_thredded_private_posts_on_postable_id_and_created_at"

  create_table "thredded_private_topics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "last_user_id"
    t.text     "title",                               null: false
    t.text     "slug",                                null: false
    t.integer  "posts_count",             default: 0
    t.string   "hash_id",      limit: 20,             null: false
    t.datetime "last_post_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "thredded_private_topics", ["hash_id"], name: "index_thredded_private_topics_on_hash_id"
  add_index "thredded_private_topics", ["last_post_at"], name: "index_thredded_private_topics_on_last_post_at"
  add_index "thredded_private_topics", ["slug"], name: "index_thredded_private_topics_on_slug", unique: true

  create_table "thredded_private_users", force: :cascade do |t|
    t.integer  "private_topic_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "thredded_private_users", ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id"
  add_index "thredded_private_users", ["user_id"], name: "index_thredded_private_users_on_user_id"

  create_table "thredded_topic_categories", force: :cascade do |t|
    t.integer "topic_id",    null: false
    t.integer "category_id", null: false
  end

  add_index "thredded_topic_categories", ["category_id"], name: "index_thredded_topic_categories_on_category_id"
  add_index "thredded_topic_categories", ["topic_id"], name: "index_thredded_topic_categories_on_topic_id"

  create_table "thredded_topics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "last_user_id"
    t.text     "title",                                       null: false
    t.text     "slug",                                        null: false
    t.integer  "messageboard_id",                             null: false
    t.integer  "posts_count",                 default: 0,     null: false
    t.boolean  "sticky",                      default: false, null: false
    t.boolean  "locked",                      default: false, null: false
    t.string   "hash_id",          limit: 20,                 null: false
    t.integer  "moderation_state",                            null: false
    t.datetime "last_post_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "thredded_topics", ["hash_id"], name: "index_thredded_topics_on_hash_id"
  add_index "thredded_topics", ["last_post_at"], name: "index_thredded_topics_on_last_post_at"
  add_index "thredded_topics", ["messageboard_id"], name: "index_thredded_topics_on_messageboard_id"
  add_index "thredded_topics", ["moderation_state", "sticky", "updated_at"], name: "index_thredded_topics_for_display"
  add_index "thredded_topics", ["slug"], name: "index_thredded_topics_on_slug", unique: true
  add_index "thredded_topics", ["user_id"], name: "index_thredded_topics_on_user_id"

  create_table "thredded_user_details", force: :cascade do |t|
    t.integer  "user_id",                                 null: false
    t.datetime "latest_activity_at"
    t.integer  "posts_count",                 default: 0
    t.integer  "topics_count",                default: 0
    t.datetime "last_seen_at"
    t.integer  "moderation_state",            default: 0, null: false
    t.datetime "moderation_state_changed_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "thredded_user_details", ["latest_activity_at"], name: "index_thredded_user_details_on_latest_activity_at"
  add_index "thredded_user_details", ["moderation_state", "moderation_state_changed_at"], name: "index_thredded_user_details_for_moderations"
  add_index "thredded_user_details", ["user_id"], name: "index_thredded_user_details_on_user_id", unique: true

  create_table "thredded_user_messageboard_preferences", force: :cascade do |t|
    t.integer  "user_id",                                  null: false
    t.integer  "messageboard_id",                          null: false
    t.boolean  "follow_topics_on_mention", default: true,  null: false
    t.boolean  "auto_follow_topics",       default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "thredded_user_messageboard_preferences", ["user_id", "messageboard_id"], name: "thredded_user_messageboard_preferences_user_id_messageboard_id", unique: true

  create_table "thredded_user_post_notifications", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "post_id",     null: false
    t.datetime "notified_at", null: false
  end

  add_index "thredded_user_post_notifications", ["post_id"], name: "index_thredded_user_post_notifications_on_post_id"
  add_index "thredded_user_post_notifications", ["user_id", "post_id"], name: "index_thredded_user_post_notifications_on_user_id_and_post_id", unique: true

  create_table "thredded_user_preferences", force: :cascade do |t|
    t.integer  "user_id",                                  null: false
    t.boolean  "follow_topics_on_mention", default: true,  null: false
    t.boolean  "auto_follow_topics",       default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "thredded_user_preferences", ["user_id"], name: "index_thredded_user_preferences_on_user_id", unique: true

  create_table "thredded_user_private_topic_read_states", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.integer  "postable_id",                    null: false
    t.integer  "unread_posts_count", default: 0, null: false
    t.integer  "read_posts_count",   default: 0, null: false
    t.integer  "integer",            default: 0, null: false
    t.datetime "read_at",                        null: false
  end

  add_index "thredded_user_private_topic_read_states", ["user_id", "postable_id"], name: "thredded_user_private_topic_read_states_user_postable", unique: true

  create_table "thredded_user_topic_follows", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.integer  "topic_id",             null: false
    t.datetime "created_at",           null: false
    t.integer  "reason",     limit: 1
  end

  add_index "thredded_user_topic_follows", ["user_id", "topic_id"], name: "thredded_user_topic_follows_user_topic", unique: true

  create_table "thredded_user_topic_read_states", force: :cascade do |t|
    t.integer  "messageboard_id",                null: false
    t.integer  "user_id",                        null: false
    t.integer  "postable_id",                    null: false
    t.integer  "unread_posts_count", default: 0, null: false
    t.integer  "read_posts_count",   default: 0, null: false
    t.integer  "integer",            default: 0, null: false
    t.datetime "read_at",                        null: false
  end

  add_index "thredded_user_topic_read_states", ["messageboard_id"], name: "index_thredded_user_topic_read_states_on_messageboard_id"
  add_index "thredded_user_topic_read_states", ["user_id", "messageboard_id"], name: "thredded_user_topic_read_states_user_messageboard"
  add_index "thredded_user_topic_read_states", ["user_id", "postable_id"], name: "thredded_user_topic_read_states_user_postable", unique: true

  create_table "undergrad_universities", force: :cascade do |t|
    t.integer  "country_id"
    t.integer  "ranking_id"
    t.string   "university_name"
    t.string   "university_type"
    t.float    "acceptance_rate"
    t.string   "location"
    t.string   "university_link"
    t.string   "university_desc"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "undergrad_universities", ["country_id", "university_name"], name: "index_undergrad_universities_on_country_id_and_university_name", unique: true
  add_index "undergrad_universities", ["country_id"], name: "index_undergrad_universities_on_country_id"
  add_index "undergrad_universities", ["ranking_id"], name: "index_undergrad_universities_on_ranking_id"

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
