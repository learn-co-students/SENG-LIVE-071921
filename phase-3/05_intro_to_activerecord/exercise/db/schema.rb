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

ActiveRecord::Schema.define(version: 2021_09_03_164519) do

  create_table "appointments", force: :cascade do |t|
    t.string "time"
    t.string "purpose"
    t.string "notes"
    t.boolean "canceled"
    t.integer "doctor_id"
    t.integer "patient_id"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "specialization"
    t.string "hospital"
    t.boolean "gives_lollipop"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.boolean "is_insured"
    t.string "insurance_provider"
    t.date "birthday"
    t.boolean "is_alive"
    t.boolean "is_organ_donor"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
end