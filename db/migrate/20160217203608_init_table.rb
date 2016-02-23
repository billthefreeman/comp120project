class InitTable < ActiveRecord::Migration
  def change
  	create_table :incidents do |t|
      t.string :location
      t.integer :status_id
      t.datetime :closed_date_time
      t.datetime :processed_date_time
      t.datetime :solved_date_time
      t.integer :severity
      t.integer :cate_id
      t.string :other_cate_description
      t.string :incident_description
      t.integer :reporter_id
      t.integer :assignee_id

      t.timestamps null: false
    end
    
  	create_table "people", force: :cascade do |t|
	    t.string   "first_name",   limit: 255
	    t.string   "last_name",    limit: 255
	    t.string   "user_name",    limit: 255
	    t.string   "phone",        limit: 255
	    t.string   "second_phone", limit: 255
	    t.string   "email",        limit: 255
	    t.integer  "group_id",     limit: 4
	    t.datetime "created_at",               null: false
	    t.datetime "updated_at",               null: false
  	end

  	create_table "statuses", force: :cascade do |t|
		t.string   "status_name", limit: 255
	    t.datetime "created_at",              null: false
	    t.datetime "updated_at",              null: false
	end

	create_table "cates", force: :cascade do |t|
    t.string   "cate_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "department_name", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "group_name",    limit: 255
    t.integer  "department_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  end
end
