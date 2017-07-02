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

ActiveRecord::Schema.define(version: 20170629203833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.inet "user_ip", null: false
    t.float "average_rating", default: 0.0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["average_rating"], name: "index_articles_on_average_rating"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "value", null: false
    t.bigint "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_ratings_on_article_id"
  end

  create_table "user_ips", force: :cascade do |t|
    t.inet "user_ip", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_user_ips_on_user_id"
    t.index ["user_ip", "user_id"], name: "index_user_ips_on_user_ip_and_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "articles", "users"
  add_foreign_key "ratings", "articles"
  add_foreign_key "user_ips", "users"
end
