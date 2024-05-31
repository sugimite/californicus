# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_05_21_121154) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string "password_digest"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_administrators_on_code", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "administrator_id", null: false
    t.date "attended_date", null: false
    t.datetime "in_at", null: false
    t.datetime "out_at"
    t.string "staying_time"
    t.boolean "is_with_no_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_attendances_on_administrator_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "grades", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.integer "year", null: false
    t.integer "score", null: false
    t.string "subject_type", null: false
    t.string "test_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "homeworks", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "administrator_id", null: false
    t.string "homework_type", null: false
    t.string "page", null: false
    t.date "assigned_date", null: false
    t.date "deadline"
    t.boolean "is_submitted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_homeworks_on_administrator_id"
    t.index ["student_id"], name: "index_homeworks_on_student_id"
  end

  create_table "memos", force: :cascade do |t|
    t.bigint "administrator_id", null: false
    t.bigint "student_id", null: false
    t.date "input_date", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id"], name: "index_memos_on_administrator_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_kana", null: false
    t.date "birthday"
    t.string "email", null: false
    t.string "password_digest"
    t.date "registration_date", null: false
    t.date "cancellation_date"
    t.integer "forgetting_hw_count"
    t.boolean "has_deposited_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "administrators"
  add_foreign_key "attendances", "students"
  add_foreign_key "grades", "students"
  add_foreign_key "homeworks", "administrators"
  add_foreign_key "homeworks", "students"
  add_foreign_key "memos", "administrators"
  add_foreign_key "memos", "students"
end
