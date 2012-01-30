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

ActiveRecord::Schema.define(:version => 20120124175057) do

  create_table "messages", :force => true do |t|
    t.text     "text",                          :null => false
    t.boolean  "section",    :default => false
    t.boolean  "pinned",     :default => false
    t.integer  "lft",                           :null => false
    t.integer  "rgt",                           :null => false
    t.string   "title",                         :null => false
    t.integer  "message_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                             :null => false
    t.string   "email",                                                :null => false
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "confirm_code"
    t.string   "sign"
    t.string   "avatar",        :default => "/assets/users/guest.png"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
