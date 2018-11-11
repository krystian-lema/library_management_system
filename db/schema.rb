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

ActiveRecord::Schema.define(version: 20181111143145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "edition"
    t.date     "publication_date"
    t.string   "ISBN"
    t.string   "signature"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "status"
  end

  create_table "borrow_archives", force: :cascade do |t|
    t.integer  "book_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "student_id"
    t.index ["book_id"], name: "index_borrow_archives_on_book_id", using: :btree
    t.index ["student_id"], name: "index_borrow_archives_on_student_id", using: :btree
  end

  create_table "borrows", force: :cascade do |t|
    t.integer  "book_id"
    t.date     "start_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "status"
    t.integer  "library_id"
    t.integer  "borrow_id"
    t.integer  "borrow_archive_id"
    t.integer  "student_id"
    t.index ["book_id"], name: "index_borrows_on_book_id", using: :btree
    t.index ["borrow_archive_id"], name: "index_borrows_on_borrow_archive_id", using: :btree
    t.index ["borrow_id"], name: "index_borrows_on_borrow_id", using: :btree
    t.index ["library_id"], name: "index_borrows_on_library_id", using: :btree
    t.index ["student_id"], name: "index_borrows_on_student_id", using: :btree
  end

  create_table "id_cards", force: :cascade do |t|
    t.integer  "number"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_id_cards_on_student_id", using: :btree
  end

  create_table "libraries", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "students", force: :cascade do |t|
    t.boolean  "is_active"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_students_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.date     "birth_date"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "borrow_archives", "books"
  add_foreign_key "borrow_archives", "students"
  add_foreign_key "borrows", "books"
  add_foreign_key "borrows", "borrow_archives"
  add_foreign_key "borrows", "borrows"
  add_foreign_key "borrows", "libraries"
  add_foreign_key "borrows", "students"
  add_foreign_key "id_cards", "students"
  add_foreign_key "students", "users"
end
