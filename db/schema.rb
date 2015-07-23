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

ActiveRecord::Schema.define(version: 20150723195352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_levels", force: :cascade do |t|
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.boolean  "read",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "option"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree

  create_table "authentication_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentication_tokens", ["user_id"], name: "index_authentication_tokens_on_user_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_id", "assetable_type"], name: "index_ckeditor_assets_on_assetable_id_and_assetable_type", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "allowed",                     default: true
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "access_level_ids",  default: [],              array: true
    t.integer  "position_ids",      default: [],              array: true
    t.integer  "department_ids",    default: [],              array: true
    t.integer  "practise_code_ids", default: [],              array: true
    t.integer  "direct_report_ids", default: [],              array: true
    t.integer  "integer",           default: [],              array: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "description"
  end

  add_index "contacts", ["access_level_ids"], name: "index_contacts_on_access_level_ids", using: :gin
  add_index "contacts", ["department_ids"], name: "index_contacts_on_department_ids", using: :gin
  add_index "contacts", ["direct_report_ids"], name: "index_contacts_on_direct_report_ids", using: :gin
  add_index "contacts", ["position_ids"], name: "index_contacts_on_position_ids", using: :gin

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "documents", ["title"], name: "index_documents_on_title", unique: true, using: :btree

  create_table "forums", force: :cascade do |t|
    t.string   "title"
    t.text     "subject"
    t.date     "expiry_date"
    t.date     "release_date"
    t.text     "tags",                       default: "--- []\n"
    t.integer  "position_ids",                                                 array: true
    t.integer  "department_ids",                                               array: true
    t.integer  "practise_code_ids",                                            array: true
    t.integer  "direct_report_ids",                                            array: true
    t.integer  "access_level_ids",                                             array: true
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "poster_avatar_file_name"
    t.string   "poster_avatar_content_type"
    t.integer  "poster_avatar_file_size"
    t.datetime "poster_avatar_updated_at"
    t.boolean  "send_push",                  default: false
    t.boolean  "send_to_all",                default: false
  end

  create_table "media_files", force: :cascade do |t|
    t.integer  "fileable_id"
    t.string   "fileable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "media_files", ["fileable_id", "fileable_type"], name: "index_media_files_on_fileable_id_and_fileable_type", using: :btree
  add_index "media_files", ["fileable_type", "fileable_id"], name: "index_media_files_on_fileable_type_and_fileable_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "message_body"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.boolean  "is_deleted",                  default: false
    t.boolean  "is_read",                     default: false
    t.integer  "parent_id"
    t.integer  "position_ids",                default: [],                 array: true
    t.integer  "department_ids",              default: [],                 array: true
    t.integer  "practise_code_ids",           default: [],                 array: true
    t.integer  "direct_report_ids",           default: [],                 array: true
    t.integer  "access_level_ids",            default: [],                 array: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "send_push",                   default: false
    t.integer  "direct_user_ids",             default: [],                 array: true
    t.boolean  "send_to_all",                 default: false
    t.string   "msg_attachment_file_name"
    t.string   "msg_attachment_content_type"
    t.integer  "msg_attachment_file_size"
    t.datetime "msg_attachment_updated_at"
  end

  create_table "news", force: :cascade do |t|
    t.date     "release_date"
    t.date     "expiry_date"
    t.text     "tags",                       default: "--- []\n"
    t.string   "content"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "title"
    t.integer  "access_level_ids",           default: [],                      array: true
    t.integer  "position_ids",               default: [],                      array: true
    t.integer  "department_ids",             default: [],                      array: true
    t.integer  "practise_code_ids",          default: [],                      array: true
    t.integer  "direct_report_ids",          default: [],                      array: true
    t.string   "poster_avatar_file_name"
    t.string   "poster_avatar_content_type"
    t.integer  "poster_avatar_file_size"
    t.datetime "poster_avatar_updated_at"
    t.string   "author_name"
    t.boolean  "send_push",                  default: false
    t.boolean  "send_to_all",                default: false
    t.text     "link"
    t.string   "pdf_file_name"
    t.string   "pdf_content_type"
    t.integer  "pdf_file_size"
    t.datetime "pdf_updated_at"
  end

  add_index "news", ["access_level_ids"], name: "index_news_on_access_level_ids", using: :gin
  add_index "news", ["department_ids"], name: "index_news_on_department_ids", using: :gin
  add_index "news", ["direct_report_ids"], name: "index_news_on_direct_report_ids", using: :gin
  add_index "news", ["position_ids"], name: "index_news_on_position_ids", using: :gin

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practise_codes", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "survey_id"
    t.string   "question"
    t.boolean  "compulsory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "response_details", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "response_id"
  end

  add_index "response_details", ["answer_id"], name: "index_response_details_on_answer_id", using: :btree
  add_index "response_details", ["question_id"], name: "index_response_details_on_question_id", using: :btree
  add_index "response_details", ["response_id"], name: "index_response_details_on_response_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.integer  "survey_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responses", ["survey_id"], name: "index_responses_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "release_date"
    t.date     "expiry_date"
    t.text     "tags",              default: "--- []\n"
    t.integer  "position_ids",      default: [],                      array: true
    t.integer  "department_ids",    default: [],                      array: true
    t.integer  "practise_code_ids", default: [],                      array: true
    t.integer  "direct_report_ids", default: [],                      array: true
    t.integer  "access_level_ids",  default: [],                      array: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "send_push",         default: false
    t.boolean  "send_to_all",       default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "postal_code"
    t.integer  "access_level_ids",                                    array: true
    t.integer  "position_ids",                                        array: true
    t.integer  "department_ids",                                      array: true
    t.integer  "practise_code_ids",                                   array: true
    t.integer  "direct_report_ids",                                   array: true
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "address"
    t.string   "fax_no"
    t.string   "device_id"
    t.string   "device_type"
    t.boolean  "can_post_feed",          default: false
    t.string   "username"
  end

  add_index "users", ["access_level_ids"], name: "index_users_on_access_level_ids", using: :gin
  add_index "users", ["department_ids"], name: "index_users_on_department_ids", using: :gin
  add_index "users", ["direct_report_ids"], name: "index_users_on_direct_report_ids", using: :gin
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["position_ids"], name: "index_users_on_position_ids", using: :gin
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "views", force: :cascade do |t|
    t.string   "viewable_type"
    t.integer  "viewable_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "views", ["user_id"], name: "index_views_on_user_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["votable_id", "votable_type"], name: "index_votes_on_votable_id_and_votable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
