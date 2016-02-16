class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :location
      t.integer :status_id
      t.datetime :report_date_time
      t.datetime :processed_date_time
      t.datetime :solved_date_time
      t.datetime :closed_date_time
      t.integer :severity
      t.integer :cate_id
      t.string :other_cate_description
      t.text :incident_description
      t.integer :reporter_id

      t.timestamps null: false
    end
  end
end
