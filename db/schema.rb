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

ActiveRecord::Schema.define(version: 2019_12_09_113603) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "visiter_id", null: false
    t.integer "visited_id", null: false
    t.integer "talk_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "post_id"
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["post_id"], name: "index_notifications_on_post_id"
    t.index ["talk_id"], name: "index_notifications_on_talk_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visiter_id"], name: "index_notifications_on_visiter_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.datetime "datetime"
    t.string "place"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "talks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "receive_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receive_user_id"], name: "index_talks_on_receive_user_id"
    t.index ["user_id"], name: "index_talks_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "apartment"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "introduction"
    t.string "photo"
    t.string "adress"
    t.string "sex"
    t.integer "age", limit: 1
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "talks", "users"
  add_foreign_key "talks", "users", column: "receive_user_id"
end
