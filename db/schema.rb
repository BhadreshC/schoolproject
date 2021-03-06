# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_12_073006) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.bigint "activeable_id"
    t.string "activeable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "C_Name"
    t.integer "standard"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "school_id"
    t.integer "studentlimit"
    t.index ["school_id"], name: "index_classrooms_on_school_id"
  end

  create_table "principles", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "school_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.boolean "status", default: false
    t.index ["confirmation_token"], name: "index_principles_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_principles_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_principles_on_school_id"
    t.index ["unlock_token"], name: "index_principles_on_unlock_token", unique: true
    t.index ["username"], name: "index_principles_on_username", unique: true
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "classroom_id"
    t.index ["classroom_id"], name: "index_students_on_classroom_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.string "MobileNo"
    t.string "qualification"
    t.string "gender", default: "Male"
    t.integer "classroom_id"
    t.index ["classroom_id"], name: "index_teachers_on_classroom_id"
    t.index ["student_id"], name: "index_teachers_on_student_id"
  end

  add_foreign_key "classrooms", "schools"
  add_foreign_key "principles", "schools"
  add_foreign_key "students", "classrooms"
  add_foreign_key "teachers", "classrooms"
  add_foreign_key "teachers", "students"
end
