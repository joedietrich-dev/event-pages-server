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

ActiveRecord::Schema.define(version: 2021_12_02_021121) do

  create_table "event_sponsor_levels", force: :cascade do |t|
    t.string "name", null: false
    t.integer "rank", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_sponsors", force: :cascade do |t|
    t.integer "event_sponsor_level_id"
    t.integer "order", default: 0, null: false
    t.integer "event_id"
    t.integer "sponsor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_sponsors_on_event_id"
    t.index ["event_sponsor_level_id"], name: "index_event_sponsors_on_event_sponsor_level_id"
    t.index ["sponsor_id"], name: "index_event_sponsors_on_sponsor_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "short_description"
    t.string "location"
    t.string "hero_src"
    t.string "register_link"
    t.string "view_link"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "honorees", force: :cascade do |t|
    t.string "honor"
    t.string "name"
    t.string "descriptor"
    t.string "bio"
    t.string "img_src"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_honorees_on_event_id"
  end

  create_table "hosts", force: :cascade do |t|
    t.string "name", null: false
    t.string "bio"
    t.string "headshot_src"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_hosts_on_event_id"
  end

  create_table "panel_panelists", force: :cascade do |t|
    t.integer "panel_id"
    t.integer "panelist_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["panel_id"], name: "index_panel_panelists_on_panel_id"
    t.index ["panelist_id"], name: "index_panel_panelists_on_panelist_id"
  end

  create_table "panel_sponsors", force: :cascade do |t|
    t.integer "panel_id"
    t.integer "sponsor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["panel_id"], name: "index_panel_sponsors_on_panel_id"
    t.index ["sponsor_id"], name: "index_panel_sponsors_on_sponsor_id"
  end

  create_table "panelists", force: :cascade do |t|
    t.string "name", null: false
    t.string "title"
    t.string "company"
    t.string "bio"
    t.string "headshot_src"
    t.string "is_moderator", default: "f", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "panels", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "time"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_panels_on_event_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo_src"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "event_sponsors", "event_sponsor_levels"
  add_foreign_key "event_sponsors", "events"
  add_foreign_key "event_sponsors", "sponsors"
  add_foreign_key "honorees", "events"
  add_foreign_key "hosts", "events"
  add_foreign_key "panel_panelists", "panelists"
  add_foreign_key "panel_panelists", "panels"
  add_foreign_key "panel_sponsors", "panels"
  add_foreign_key "panel_sponsors", "sponsors"
  add_foreign_key "panels", "events"
end
