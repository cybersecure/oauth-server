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

ActiveRecord::Schema.define(:version => 20110923054330) do

  create_table "authorization_requests", :force => true do |t|
    t.string   "response_type"
    t.integer  "client_application_id"
    t.string   "scope"
    t.string   "redirect_uri"
    t.string   "state"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_applications", :force => true do |t|
    t.string   "app_id"
    t.string   "app_secret"
    t.string   "app_url"
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