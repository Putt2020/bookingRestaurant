json.extract! comment, :id, :msg, :user_id, :restaurant_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
