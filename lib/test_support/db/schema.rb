require 'sniff/database'

Sniff::Database.define_schema do
  create_table "motorcycle_records", :force => true do |t|
    t.string   "name"
    t.integer  "profile_id"
    t.date     "date"
    t.float    "fuel_efficiency"
    t.float    "annual_distance_estimate"
    t.float    "weekly_distance_estimate"
    t.date     "acquisition"
    t.date     "retirement"
    t.datetime "updated_at"
    t.datetime "created_at"
  end
end
