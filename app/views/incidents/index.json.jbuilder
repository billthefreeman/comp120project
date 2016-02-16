json.array!(@incidents) do |incident|
  json.extract! incident, :id, :location, :status_id, :report_date_time, :processed_date_time, :solved_date_time, :closed_date_time, :severity, :cate_id, :other_cate_description, :incident_description, :reporter_id
  json.url incident_url(incident, format: :json)
end
