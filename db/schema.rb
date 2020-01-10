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

ActiveRecord::Schema.define(version: 2020_01_09_042556) do

	create_table "classrooms", force: :cascade do |t|
		t.string "C_Name"
		t.integer "wichstandard"
		t.datetime "created_at", precision: 6, null: false
		t.datetime "updated_at", precision: 6, null: false
		t.integer "school_id"
		t.index ["school_id"], name: "index_classrooms_on_school_id"
	end

	create_table "principles", force: :cascade do |t|
		t.string "username"
		t.string "email"
		t.string "password_digest"
		t.datetime "created_at", precision: 6, null: false
		t.datetime "updated_at", precision: 6, null: false
		t.integer "school_id"
		t.index ["school_id"], name: "index_principles_on_school_id"
	end

	create_table "schools", force: :cascade do |t|
		t.string "name"
		t.string "princile"
		t.datetime "created_at", precision: 6, null: false
		t.datetime "updated_at", precision: 6, null: false
	end

	create_table "students", force: :cascade do |t|
		t.string "name"
		t.string "email"
		t.integer "standard"
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
		t.index ["student_id"], name: "index_teachers_on_student_id"
	end

	add_foreign_key "classrooms", "schools"
	add_foreign_key "principles", "schools"
	add_foreign_key "students", "classrooms"
	add_foreign_key "teachers", "students"
end
