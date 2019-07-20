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

ActiveRecord::Schema.define(version: 2019_07_20_152508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "choice_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_answers_on_choice_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.string "content_type"
    t.binary "file"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_attachments_on_message_id"
  end

  create_table "avatars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "url", default: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wcUBzIzZrD8tgAAAAxpVFh0Q29tbWVudAAAAAAAvK6ymQAAAAtJREFUCNdjYAACAAAFAAHiJgWbAAAAAElFTkSuQmCC", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_avatars_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "text", null: false
    t.bigint "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_choices_on_poll_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "protocol", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.integer "level", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "user_id", null: false
    t.integer "value", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_likes_on_message_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.boolean "section", default: false
    t.boolean "pinned", default: false
    t.bigint "message_id"
    t.bigint "user_id", null: false
    t.bigint "nv", default: 0
    t.bigint "dv", default: 0
    t.bigint "snv", default: 0
    t.bigint "sdv", default: 0
    t.boolean "follow", default: true
    t.bigint "writer_id", default: 1, null: false
    t.bigint "reader_id", default: 1, null: false
    t.bigint "moderator_id", default: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_messages_on_message_id"
    t.index ["moderator_id"], name: "index_messages_on_moderator_id"
    t.index ["reader_id"], name: "index_messages_on_reader_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["writer_id"], name: "index_messages_on_writer_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_polls_on_message_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.text "sign"
    t.date "birthday"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "answers", "choices"
  add_foreign_key "answers", "users"
  add_foreign_key "attachments", "messages"
  add_foreign_key "avatars", "users"
  add_foreign_key "choices", "polls"
  add_foreign_key "contacts", "users"
  add_foreign_key "likes", "messages"
  add_foreign_key "likes", "users"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "groups", column: "moderator_id"
  add_foreign_key "messages", "groups", column: "reader_id"
  add_foreign_key "messages", "groups", column: "writer_id"
  add_foreign_key "messages", "messages"
  add_foreign_key "messages", "users"
  add_foreign_key "polls", "messages"
end
