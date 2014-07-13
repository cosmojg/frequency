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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130105130419) do

  create_table "activities", :force => true do |t|
    t.integer  "activity_creator_id"
    t.string   "activity_creator_type"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
  end

  add_index "blogs", ["created_at"], :name => "index_blogs_on_created_at"

  create_table "boards", :force => true do |t|
    t.string   "title",      :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "picture_id"
    t.text     "body"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "cached_votes_total", :default => 0
    t.integer  "cached_votes_up",    :default => 0
    t.integer  "cached_votes_down",  :default => 0
  end

  add_index "comments", ["cached_votes_down"], :name => "index_comments_on_cached_votes_down"
  add_index "comments", ["cached_votes_total"], :name => "index_comments_on_cached_votes_total"
  add_index "comments", ["cached_votes_up"], :name => "index_comments_on_cached_votes_up"
  add_index "comments", ["picture_id"], :name => "index_comments_on_picture_id"

  create_table "conversations", :force => true do |t|
    t.string   "title"
    t.integer  "board_id"
    t.integer  "user_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.datetime "last_reply_at"
    t.integer  "posts_count",   :default => 0
  end

  add_index "conversations", ["board_id"], :name => "index_conversations_on_board_id"
  add_index "conversations", ["last_reply_at"], :name => "index_conversations_on_last_reply_at"
  add_index "conversations", ["user_id"], :name => "index_conversations_on_user_id"

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "photo_url"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "photo_url_file_name"
    t.string   "photo_url_content_type"
    t.integer  "photo_url_file_size"
    t.datetime "photo_url_updated_at"
    t.text     "caption"
    t.integer  "views",                  :default => 0, :null => false
  end

  add_index "pictures", ["created_at"], :name => "index_pictures_on_created_at"
  add_index "pictures", ["user_id"], :name => "index_pictures_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.text     "body"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "cached_votes_total", :default => 0
    t.integer  "cached_votes_up",    :default => 0
    t.integer  "cached_votes_down",  :default => 0
  end

  add_index "posts", ["cached_votes_down"], :name => "index_posts_on_cached_votes_down"
  add_index "posts", ["cached_votes_total"], :name => "index_posts_on_cached_votes_total"
  add_index "posts", ["cached_votes_up"], :name => "index_posts_on_cached_votes_up"
  add_index "posts", ["conversation_id"], :name => "index_posts_on_conversation_id"
  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "throttles", :force => true do |t|
    t.integer  "user_id"
    t.string   "model"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "throttles", ["user_id", "model"], :name => "index_throttles_on_user_id_and_model", :unique => true

  create_table "unread_states", :force => true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "after"
  end

  add_index "unread_states", ["conversation_id"], :name => "index_unread_states_on_conversation_id"
  add_index "unread_states", ["user_id"], :name => "index_unread_states_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "wiiu_id"
    t.string   "xbox_live"
    t.string   "psn"
    t.string   "steam"
    t.string   "friendcode"
    t.integer  "login_count",          :default => 0, :null => false
    t.integer  "failed_login_count",   :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "last_unread_check_at"
    t.string   "role"
    t.integer  "posts_count",          :default => 0
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
