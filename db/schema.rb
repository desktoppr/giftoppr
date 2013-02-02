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

ActiveRecord::Schema.define(:version => 20130202071957) do

  create_table "gifs", :force => true do |t|
    t.string   "file",        :null => false
    t.integer  "width",       :null => false
    t.integer  "height",      :null => false
    t.string   "unique_hash", :null => false
    t.integer  "bytes",       :null => false
    t.integer  "uploader_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "gifs", ["unique_hash"], :name => "index_gifs_on_unique_hash"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "provider",      :null => false
    t.string   "uid",           :null => false
    t.string   "name",          :null => false
    t.string   "email",         :null => false
    t.string   "oauth_token",   :null => false
    t.string   "oauth_secret",  :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "change_cursor"
  end

  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid"

end
