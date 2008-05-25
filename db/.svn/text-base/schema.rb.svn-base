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

ActiveRecord::Schema.define(:version => 17) do

  create_table "attachments", :force => true do |t|
    t.integer  "topic_id"
    t.string   "filename"
    t.string   "filetype"
    t.integer  "filesize",   :default => 0
    t.string   "filepath",   :default => ""
    t.integer  "downloads",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "isimage",    :default => 0
  end

  create_table "categories", :force => true do |t|
    t.integer "parent_id",    :default => 0
    t.string  "title"
    t.string  "desc"
    t.integer "position",     :default => 0
    t.integer "topics_count", :default => 0
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "type_id"
    t.integer  "topic_id"
    t.string   "name"
    t.string   "email",      :default => " @ "
    t.string   "website",    :default => "http://"
    t.datetime "created_at"
    t.string   "remote_ip"
  end

  create_table "configurations", :force => true do |t|
    t.string "name"
    t.string "title"
    t.string "description"
    t.text   "value"
    t.string "group"
  end

  create_table "links", :force => true do |t|
    t.integer "parent_id",   :default => 0
    t.string  "title"
    t.string  "description"
    t.string  "weburl",      :default => "http://"
    t.integer "position"
    t.integer "visible",     :default => 1
  end

  create_table "natures", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.integer "topics_count", :default => 0
    t.integer "position",     :default => 0
  end

  create_table "statistics", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.integer "topics_count", :default => 0
  end

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.string   "time"
    t.string   "author"
    t.string   "description"
    t.string   "homepage"
    t.string   "preview"
    t.string   "pwd"
    t.string   "useit",       :default => "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_id",           :default => 0
    t.integer  "category_id",       :default => 0
    t.integer  "tag_id",            :default => 0
    t.string   "attachment_id",     :default => ""
    t.integer  "user_id",           :default => 0
    t.integer  "views_count",       :default => 0
    t.integer  "comments_count",    :default => 0
    t.integer  "istop",             :default => 0
    t.string   "remote_ip",         :default => ""
    t.string   "keys",              :default => ""
    t.integer  "visible",           :default => 1
    t.integer  "closecomment",      :default => 0
    t.string   "readpassword",      :default => ""
    t.integer  "showsnippet",       :default => 1
    t.integer  "snippetcounts",     :default => 200
    t.integer  "track_backs_count", :default => 0
    t.integer  "nature_id",         :default => 1
  end

  create_table "track_backs", :force => true do |t|
    t.integer  "topic_id"
    t.string   "title",      :default => "TrackBack Titel"
    t.string   "excerpt",    :default => "TrackBack Excerpt"
    t.string   "blog_name",  :default => "Blog Name"
    t.string   "url",        :default => "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_ip",  :default => ""
    t.integer  "visible",    :default => 0
  end

  create_table "user_groups", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.integer "users_count", :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "login_name"
    t.string   "nickname"
    t.string   "hashed_pass"
    t.string   "email"
    t.string   "im"
    t.text     "personality"
    t.binary   "data"
    t.string   "content_type"
    t.integer  "user_group_id",  :default => 1
    t.integer  "topics_count",   :default => 0
    t.integer  "comments_count", :default => 0
    t.datetime "created_at",     :default => '2008-05-25 02:05:16'
    t.datetime "updated_at"
    t.text     "note"
  end

end
