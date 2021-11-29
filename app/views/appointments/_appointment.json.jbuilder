json.extract! appointment, :id, :user_id, :table_id, :start_time, :people_amount, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
