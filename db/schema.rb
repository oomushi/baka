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

ActiveRecord::Schema.define(version: 2019_07_20_073423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "choice_id"
    t.bigint "user_id"
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
    t.bigint "user_id"
    t.text "url", default: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4wcUBzIzZrD8tgAAAAxpVFh0Q29tbWVudAAAAAAAvK6ymQAAAAtJREFUCNdjYAACAAAFAAHiJgWbAAAAAElFTkSuQmCC"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_avatars_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "text"
    t.bigint "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_choices_on_poll_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "protocol"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_likes_on_message_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.boolean "section"
    t.boolean "pinned"
    t.bigint "message_id"
    t.bigint "user_id"
    t.integer "nv"
    t.integer "dv"
    t.integer "snv"
    t.integer "sdv"
    t.boolean "follow"
    t.bigint "writer_id"
    t.bigint "reader_id"
    t.bigint "moderator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_messages_on_message_id"
    t.index ["moderator_id"], name: "index_messages_on_moderator_id"
    t.index ["reader_id"], name: "index_messages_on_reader_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["writer_id"], name: "index_messages_on_writer_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "title"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_polls_on_message_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "sign"
    t.date "birthday"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
