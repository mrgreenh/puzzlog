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

ActiveRecord::Schema.define(:version => 20131001043929) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.boolean  "public"
    t.datetime "publication_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
  end

  add_index "articles", ["title"], :name => "index_articles_on_title", :unique => true

  create_table "bags", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bags", ["user_id", "name"], :name => "index_bags_on_user_id_and_name", :unique => true

  create_table "fragment_image_relationships", :force => true do |t|
    t.integer  "fragment_id"
    t.integer  "fragment_image_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "fragment_images", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.string   "fragment_resource_file_file_name"
    t.string   "fragment_resource_file_content_type"
    t.integer  "fragment_resource_file_file_size"
    t.datetime "fragment_resource_file_updated_at"
    t.hstore   "data"
    t.string   "media_fragment"
  end

  create_table "fragment_sound_relationships", :force => true do |t|
    t.integer  "fragment_id"
    t.integer  "fragment_sound_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "fragment_sounds", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.string   "fragment_resource_file_file_name"
    t.string   "fragment_resource_file_content_type"
    t.integer  "fragment_resource_file_file_size"
    t.datetime "fragment_resource_file_updated_at"
    t.hstore   "data"
  end

  create_table "fragment_types", :force => true do |t|
    t.string   "name"
    t.text     "edit_elements"
    t.text     "view_elements"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "stylesheet"
    t.integer  "images"
    t.integer  "sounds"
    t.integer  "videos"
    t.integer  "untyped_attachments"
    t.string   "summary_fields"
    t.text     "description"
    t.text     "script"
    t.hstore   "default_data"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "fragment_untyped_attachment_relationships", :force => true do |t|
    t.integer  "fragment_id"
    t.integer  "fragment_untyped_attachment_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "fragment_untyped_attachments", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.string   "fragment_resource_file_file_name"
    t.string   "fragment_resource_file_content_type"
    t.integer  "fragment_resource_file_file_size"
    t.datetime "fragment_resource_file_updated_at"
    t.hstore   "data"
  end

  create_table "fragment_video_relationships", :force => true do |t|
    t.integer  "fragment_id"
    t.integer  "fragment_video_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "fragment_videos", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.string   "fragment_resource_file_file_name"
    t.string   "fragment_resource_file_content_type"
    t.integer  "fragment_resource_file_file_size"
    t.datetime "fragment_resource_file_updated_at"
    t.hstore   "data"
  end

  create_table "fragments", :force => true do |t|
    t.integer  "fragment_type_id"
    t.string   "name"
    t.boolean  "stand_alone"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.datetime "publication_date"
    t.boolean  "public"
    t.hstore   "data"
  end

  add_index "fragments", ["data"], :name => "fragments_gist_data"

  create_table "menu_entries", :force => true do |t|
    t.integer  "article_id"
    t.integer  "order"
    t.string   "link_type"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "page_fragment_relationships", :force => true do |t|
    t.integer  "page_id"
    t.integer  "fragment_id"
    t.integer  "ordering_number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "page_fragment_relationships", ["fragment_id", "page_id"], :name => "index_page_fragment_relationships_on_fragment_id_and_page_id", :unique => true

  create_table "pages", :force => true do |t|
    t.integer  "number"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "article_id"
    t.string   "foreground_color"
    t.string   "background_color"
    t.string   "third_color"
    t.string   "name"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_box_fragment_relationships", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "bag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_box_fragment_relationships", ["user_id", "resource_id"], :name => "box_fragment_unique_index_on_user_id_resource_id", :unique => true

  create_table "user_box_image_relationships", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "bag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_box_image_relationships", ["user_id", "resource_id"], :name => "index_user_box_image_relationships_on_user_id_and_resource_id", :unique => true

  create_table "user_box_sound_relationships", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "bag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_box_sound_relationships", ["user_id", "resource_id"], :name => "index_user_box_sound_relationships_on_user_id_and_resource_id", :unique => true

  create_table "user_box_untyped_attachment_relationships", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "bag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_box_untyped_attachment_relationships", ["user_id", "resource_id"], :name => "box_untyped_attachment_unique_index_on_user_id_resource_id", :unique => true

  create_table "user_box_video_relationships", :force => true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "bag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_box_video_relationships", ["user_id", "resource_id"], :name => "index_user_box_video_relationships_on_user_id_and_resource_id", :unique => true

  create_table "user_role_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_role_relationships", ["user_id", "role_id"], :name => "index_user_role_relationships_on_user_id_and_role_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "remember_token"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
