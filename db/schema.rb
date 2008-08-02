# This file is auto-generated from the current state of the database. Instead of editing this file,
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080801214649) do

  create_table "forum_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_options", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.integer  "forum_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "forum_options", ["forum_id"], "forums", ["id"], :deferrable => true, :name => "forum_options_forum_id_fkey"

  add_foreign_key "forums", ["parent_id"], "forums", ["id"], :deferrable => true, :name => "forums_parent_id_fkey"
  add_foreign_key "forums", ["forum_category_id"], "forum_categories", ["id"], :deferrable => true, :name => "forums_forum_category_id_fkey"

end
