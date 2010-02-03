# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "feeds", :force => true do |t|
    t.string   "link"
    t.string   "heading"
    t.string   "title"
    t.boolean  "is_read",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailings", :force => true do |t|
    t.integer  "feed_id"
    t.text     "message_body"
    t.string   "message_subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "keep_time",  :default => "60"
    t.boolean  "purge",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
