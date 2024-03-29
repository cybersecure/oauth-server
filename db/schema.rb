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

ActiveRecord::Schema.define(:version => 20110926052303) do

  create_table "access_requests", :force => true do |t|
    t.integer  "authorization_request_id"
    t.string   "grant_type"
    t.string   "redirect_uri"
    t.string   "access_token"
    t.string   "token_type"
    t.integer  "expires_in"
    t.string   "state"
    t.string   "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorization_requests", :force => true do |t|
    t.string   "response_type"
    t.string   "client_application_id"
    t.integer  "user_id"
    t.string   "redirect_uri"
    t.string   "scope"
    t.string   "state"
    t.string   "code"
    t.datetime "expire_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_applications", :force => true do |t|
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "client_url"
    t.string   "description"
    t.string   "logo_url"
    t.string   "client_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "active"
    t.string   "language"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
