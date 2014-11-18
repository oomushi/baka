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

ActiveRecord::Schema.define(:version => 20141118212347) do

  create_table "answers", :force => true do |t|
    t.string   "text",       :null => false
    t.integer  "poll_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "answers_users", :id => false, :force => true do |t|
    t.integer "user_id",   :null => false
    t.integer "answer_id", :null => false
  end

  add_index "answers_users", ["user_id", "answer_id"], :name => "index_poll_options_users_on_user_id_and_poll_option_id", :unique => true

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.string   "content_type"
    t.binary   "file"
    t.integer  "message_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "avatars", :force => true do |t|
    t.integer  "user_id",                                       :null => false
    t.string   "url",          :default => "/assets/guest.png"
    t.binary   "file"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "content_type"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "protocol"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "level",      :default => 1
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "user_id",  :null => false
  end

  add_index "groups_users", ["group_id", "user_id"], :name => "index_groups_users_on_group_id_and_user_id", :unique => true

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.integer  "value",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "likes", ["user_id", "message_id"], :name => "index_likes_on_user_id_and_message_id", :unique => true

  create_table "messages", :force => true do |t|
    t.text     "text",                                         :null => false
    t.boolean  "section",                   :default => false
    t.boolean  "pinned",                    :default => false
    t.string   "title",                                        :null => false
    t.integer  "message_id",                                   :null => false
    t.integer  "user_id",                                      :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "nv",           :limit => 8, :default => 0
    t.integer  "dv",           :limit => 8, :default => 0
    t.integer  "snv",          :limit => 8, :default => 0
    t.integer  "sdv",          :limit => 8, :default => 0
    t.boolean  "follow",                    :default => true
    t.integer  "writer_id",                 :default => 1,     :null => false
    t.integer  "reader_id",                 :default => 1,     :null => false
    t.integer  "moderator_id",              :default => 2,     :null => false
  end

  create_table "polls", :force => true do |t|
    t.string   "title",      :null => false
    t.integer  "message_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                         :null => false
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "confirm_code",  :default => ""
    t.string   "sign"
    t.date     "birthday"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "location"
    t.boolean  "guest",         :default => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
