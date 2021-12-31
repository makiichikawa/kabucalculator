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

ActiveRecord::Schema.define(version: 0) do

  create_table "indicators", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "symbol", limit: 5, null: false
    t.integer "price", null: false
    t.float "myuhat_short", limit: 53, null: false
    t.float "sigmahat_short", limit: 53, null: false
    t.float "probability_short", limit: 53, null: false
    t.float "myuhat_medium", limit: 53, null: false
    t.float "sigmahat_medium", limit: 53, null: false
    t.float "probability_medium", limit: 53, null: false
    t.float "myuhat_long", limit: 53, null: false
    t.float "sigmahat_long", limit: 53, null: false
    t.float "probability_long", limit: 53, null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "update_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

end
